import 'package:shoplocal/features/product/dto/productComCategory.dart';
import 'package:shoplocal/features/product/models/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductDao {
  ProductDao(this._bancoDados);

  final Database _bancoDados;
  final String _table = 'product';

  Future<List<Product>> buscarTodos() async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      orderBy: 'name',
    );

    return resultado.map(Product.fromMap).toList();
  }

  Future<List<ProductWithCategory>> btobuscarPorCat(int categoryId) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.rawQuery(
      '''
        SELECT 
        p.id,
        p.name,
        p.description,
        p.price,
        p.imageUrl,
        p.categoryId,
        c.name as categoryName
        FROM product as p
        INNER JOIN category as c
        ON p.categoryId = c.id

        WHERE p.categoryId = ?
    ''',
      [categoryId],
    );

    return resultado.map(ProductWithCategory.fromMap).toList();
  }

  Future<List<Product>> buscarPorCategoria(int categoryId) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      orderBy: 'name',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );

    return resultado.map(Product.fromMap).toList();
  }

  Future<Product> buscarPorId(int id) async {
    final List<Map<String, dynamic>> resultado = await _bancoDados.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return Product.fromMap(resultado.first);
  }

  Future<void> inserir(Product product) async {
    await _bancoDados.insert(_table, product.toMap());
  }

  Future<void> alterar(Product product) async {
    await _bancoDados.update(
      _table,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> excluir(int id) async {
    await _bancoDados.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
