import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Conexao {
  Conexao._();

  static final instancia = Conexao._();

  static const String _nomeBanco = 'local_shop.db';
  static const String _nomeBancoWeb = 'local_shop_web.db';

  Database? _bancoDados;

  Future<Database> get bancoDados async {
    final Database? bancoAberto = _bancoDados;

    if (bancoAberto != null) {
      return bancoAberto;
    }

    Database novoBanco = await _abrir();
    _bancoDados = novoBanco;

    return novoBanco;
  }

  Future<Database> _abrir() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    final caminho = kIsWeb
        ? _nomeBancoWeb
        : p.join(await getDatabasesPath(), _nomeBanco);

    return openDatabase(
      caminho,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE user(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE category(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            descricao TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE store(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            address TEXT NOT NULL,
            phone TEXT NOT NULL,
            email TEXT NOT NULL,
            adminId INTEGER NOT NULL,
            FOREIGN KEY (adminId) REFERENCES user(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE product(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            price REAL NOT NULL,
            categoryId INTEGER NOT NULL,
            storeId INTEGER NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES category(id),
            FOREIGN KEY (storeId) REFERENCES store(id)
          )
        ''');

        await _popularBancoInicial(db);
      },
    ).then((Database db) async {
      await _popularBancoSeVazio(db);
      return db;
    });
  }

  Future<void> _popularBancoSeVazio(Database db) async {
    final List<Map<String, Object?>> usuarios = await db.query(
      'user',
      columns: ['id'],
      limit: 1,
    );

    if (usuarios.isNotEmpty) {
      return;
    }

    await _popularBancoInicial(db);
  }

  Future<void> _popularBancoInicial(Database db) async {
    await db.execute(
      "INSERT INTO user (name, email, password) VALUES ('Admin LocalShop', 'admin@localshop.com', '123456')",
    );
    await db.execute(
      "INSERT INTO user (name, email, password) VALUES ('Operador Loja', 'operador@localshop.com', '123456')",
    );

    await db.execute(
      "INSERT INTO category (name, descricao) VALUES ('ALIMENTAÇÃO', 'Produtos de mercearia, padaria e lanches')",
    );
    await db.execute(
      "INSERT INTO category (name, descricao) VALUES ('MODA', 'Roupas, acessórios e itens de vestuário')",
    );
    await db.execute(
      "INSERT INTO category (name, descricao) VALUES ('CASA', 'Itens para decoração e utilidades domésticas')",
    );

    await db.execute(
      "INSERT INTO store (name, address, phone, email, adminId) VALUES ('Loja Centro', 'Rua Central, 120', '(11) 99999-0001', 'centro@localshop.com', 1)",
    );
    await db.execute(
      "INSERT INTO store (name, address, phone, email, adminId) VALUES ('Loja Bairro', 'Avenida Principal, 450', '(11) 99999-0002', 'bairro@localshop.com', 2)",
    );

    await db.execute(
      "INSERT INTO product (name, description, price, categoryId, storeId) VALUES ('Pão Francês', 'Pacote com 6 unidades', 8.5, 1, 1)",
    );
    await db.execute(
      "INSERT INTO product (name, description, price, categoryId, storeId) VALUES ('Camiseta Básica', 'Algodão, cor branca, tamanho M', 39.9, 2, 2)",
    );
    await db.execute(
      "INSERT INTO product (name, description, price, categoryId, storeId) VALUES ('Luminária de Mesa', 'Estrutura metálica com base articulada', 129.9, 3, 1)",
    );
  }
}
