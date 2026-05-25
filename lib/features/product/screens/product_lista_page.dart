import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:shoplocal/core/database/database.dart';
import 'package:shoplocal/features/product/dao/categoryDao.dart';
import 'package:shoplocal/features/product/dao/productDao.dart';
import 'package:shoplocal/features/product/models/category.dart';
import 'package:shoplocal/features/product/models/product.dart';
import 'package:shoplocal/features/product/screens/product_form_page.dart';
import 'package:shoplocal/features/store/dao/storeDao.dart';
import 'package:shoplocal/features/store/model/store.dart';

class ProductListaPage extends StatefulWidget {
  const ProductListaPage({super.key});

  @override
  State<ProductListaPage> createState() => _ProductListaPageState();
}

class _ProductListaPageState extends State<ProductListaPage> {
  List<Product> produtos = [];
  List<Category> categorias = [];
  List<Store> lojas = [];
  Category? categoriaFiltro;
  Store? lojaFiltro;

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
    _carregarLojas();
    _listar();
  }

  Future<void> _carregarCategorias() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<Category> encontrados = await CategoryDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      categorias = encontrados;
    });
  }

  Future<void> _carregarLojas() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<Store> encontradas = await StoreDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      lojas = encontradas;
    });
  }

  Future<void> _listar() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final ProductDao dao = ProductDao(banco);

    final Category? filtroCategoria = categoriaFiltro;
    final Store? filtroLoja = lojaFiltro;

    final List<Product> encontradas = await dao.buscarTodos();

    final List<Product> filtradas = encontradas.where((Product produto) {
      final bool porCategoria =
          filtroCategoria == null || produto.categoryId == filtroCategoria.id;
      final bool porLoja =
          filtroLoja == null || produto.storeId == filtroLoja.id;
      return porCategoria && porLoja;
    }).toList();

    if (!mounted) return;

    setState(() {
      produtos = filtradas;
    });
  }

  Future<void> _excluir(int id) async {
    final Database banco = await Conexao.instancia.bancoDados;
    await ProductDao(banco).excluir(id);
    await _listar();

    if (!mounted) return;

    _mostrarMensagem('Produto excluído com sucesso');
  }

  Future<void> _abrirFormulario({Product? product}) async {
    final bool? salvou = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductFormPage(product: product)),
    );

    if (salvou == true) {
      await _listar();
      if (!mounted) return;

      _mostrarMensagem(
        product == null
            ? 'Produto cadastrado com sucesso'
            : 'Produto atualizado com sucesso',
      );
    }
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  String _descricaoCategoria(int? categoriaId) {
    for (final Category categoria in categorias) {
      if (categoria.id == categoriaId) {
        return categoria.name;
      }
    }

    return 'Categoria $categoriaId';
  }

  String _descricaoLoja(int? lojaId) {
    for (final Store loja in lojas) {
      if (loja.id == lojaId) {
        return loja.name;
      }
    }

    return 'Loja $lojaId';
  }

  String _preco(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () => _abrirFormulario(),
            icon: const Icon(Icons.add),
            label: const Text('Cadastrar produto'),
          ),
          const SizedBox(height: 12),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Filtrar por categoria',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            child: DropdownButton<Category?>(
              value: categoriaFiltro,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: [
                const DropdownMenuItem<Category?>(
                  value: null,
                  child: Text('Todas as categorias'),
                ),
                for (final Category categoria in categorias)
                  DropdownMenuItem<Category?>(
                    value: categoria,
                    child: Text(categoria.name),
                  ),
              ],
              onChanged: (Category? valor) {
                setState(() {
                  categoriaFiltro = valor;
                });
                _listar();
              },
            ),
          ),
          const SizedBox(height: 12),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Filtrar por loja',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            child: DropdownButton<Store?>(
              value: lojaFiltro,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: [
                const DropdownMenuItem<Store?>(
                  value: null,
                  child: Text('Todas as lojas'),
                ),
                for (final Store loja in lojas)
                  DropdownMenuItem<Store?>(value: loja, child: Text(loja.name)),
              ],
              onChanged: (Store? valor) {
                setState(() {
                  lojaFiltro = valor;
                });
                _listar();
              },
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Registros encontrados: ${produtos.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final Product produto in produtos)
            Card(
              child: ListTile(
                title: Text(produto.name),
                subtitle: Text(
                  '${_descricaoCategoria(produto.categoryId)} | ${_descricaoLoja(produto.storeId)} | ${_preco(produto.price)}',
                ),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      tooltip: 'Alterar',
                      icon: const Icon(Icons.edit),
                      onPressed: () => _abrirFormulario(product: produto),
                    ),
                    IconButton(
                      tooltip: 'Excluir',
                      icon: const Icon(Icons.delete),
                      onPressed: () => _excluir(produto.id!),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
