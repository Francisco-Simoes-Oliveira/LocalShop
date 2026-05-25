import 'dart:async';

import 'package:shoplocal/features/product/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  CategoryDao(this._bancoDados);

  final Database _bancoDados;

  final String _table = 'category';

  Future<List<Category>> buscarTodos() async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.rawQuery(
      'SELECT * FROM $_table ORDER BY name',
    );

    return resultado.map(Category.fromMap).toList();
  }

  Future<Category?> buscaPorID(int id) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) return null;

    return Category.fromMap(resultado.first);
  }

  Future<void> incerir(Category category) async {
    await _bancoDados.insert(_table, category.toMap());
  }

  Future<void> alter(Category category) async {
    await _bancoDados.update(
      _table,
      category.toMap(),
      where: 'id =?',
      whereArgs: [category.id],
    );
  }

  Future<void> excluir(int id) async {
    await _bancoDados.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
