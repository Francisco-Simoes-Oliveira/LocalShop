import 'package:sqflite/sqflite.dart';

import '../model/store.dart';

class StoreDao {
  StoreDao(this._bancoDados);

  final Database _bancoDados;

  final String _table = 'store';

  Future<List<Store>> buscarTodos() async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      orderBy: 'name',
    );

    return resultado.map(Store.fromMap).toList();
  }

  Future<Store> buscarPorAdmin(int adminId) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      where: 'adminId = ?',
      whereArgs: [adminId],
    );

    return Store.fromMap(resultado.first);
  }
}
