import 'dart:async';

import 'package:shoplocal/features/product/models/tag.dart';
import 'package:sqflite/sqflite.dart';

class TagDao {
  TagDao(this._bancoDados);

  final Database _bancoDados;

  final String _table = 'tag';

  Future<List<Tag>> buscarTodos() async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.rawQuery(
      'SELECT * FROM $_table ORDER BY name',
    );

    return resultado.map(Tag.fromMap).toList();
  }

  Future<Tag?> buscaPorID(int id) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) return null;

    return Tag.fromMap(resultado.first);
  }

  Future<void> incerir(Tag tag) async {
    await _bancoDados.insert(_table, tag.toMap());
  }

  Future<void> alter(Tag tag) async {
    await _bancoDados.update(
      _table,
      tag.toMap(),
      where: 'id =?',
      whereArgs: [tag.id],
    );
  }

  Future<void> excluir(int id) async {
    await _bancoDados.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
