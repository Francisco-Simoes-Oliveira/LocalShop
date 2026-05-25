import 'package:sqflite/sqflite.dart';

import '../model/store.dart';

class StoreDao {
  StoreDao(this._bancoDados);

  final Database _bancoDados;

  static const String _table = 'store';

  Future<List<Store>> buscarTodos() async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      orderBy: 'name',
    );

    return resultado.map(Store.fromMap).toList();
  }

  Future<Store?> buscarPorAdmin(int adminId) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      where: 'admin_id = ?',
      whereArgs: [adminId],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return Store.fromMap(resultado.first);
  }

  Future<void> inserir(Store store) async {
    await _bancoDados.insert(_table, store.toMap());
  }

  Future<void> alterar(Store store) async {
    await _bancoDados.update(
      _table,
      store.toMap(),
      where: 'id = ?',
      whereArgs: [store.id],
    );
  }

  Future<void> excluir(int id) async {
    await _bancoDados.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
