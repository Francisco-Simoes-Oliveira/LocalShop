import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Conexao {
  Conexao._();

  static final intancia = Conexao._();

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
            name TEXT NOT NULL VARCHAR(60),
            email TEXT NOT NULL VARCHAR(80),
            password TEXT NOT VARCHAR(70)
          )

      ''');
        await db.execute('''
          CREATE TABLE category(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL VARCHAR(60),
            descricao TEXT NOT NULL VARCHAR(200)
          )
          
      ''');

        await db.execute('''
        CREATE TABLE product(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL VARCHAR(60),
          description TEXT NOT NULL VARCHAR(200),
          price REAL NOT NULL,
          categoryId INTEGER NOT NULL,
          FOREIGN KEY (categoryId) REFERENCES category(id)
        ) 
      ''');
        await db.execute('''
        CREATE TABLE store(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL VARCHAR(60),
          adminId INTEGER NOT NULL,
          FOREIGN KEY (adminId) REFERENCES user(id)
        ) 
       ''');
      },
    );
  }
}
