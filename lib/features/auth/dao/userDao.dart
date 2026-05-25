import 'dart:async';

import 'package:shoplocal/features/auth/model/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  UserDao(this._bancoDados);

  final Database _bancoDados;

  final String _table = 'user';

  Future<List<User>> buscarTodos() async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.rawQuery(
      'SELECT * FROM $_table ORDER BY name',
    );

    return resultado.map(User.fromMap).toList();
  }

  Future<User?> buscaPorID(int id) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) return null;

    return User.fromMap(resultado.first);
  }

  Future<void> incerir(User user) async {
    await _bancoDados.insert(_table, user.toMap());
  }

  Future<void> alter(User user) async {
    await _bancoDados.update(
      _table,
      user.toMap(),
      where: 'id =?',
      whereArgs: [user.id],
    );
  }

  Future<void> excluir(int id) async {
    await _bancoDados.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
