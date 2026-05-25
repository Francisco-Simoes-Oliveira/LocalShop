import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:shoplocal/core/database/database.dart';
import 'package:shoplocal/features/product/dao/categoryDao.dart';
import 'package:shoplocal/features/product/dao/productDao.dart';
import 'package:shoplocal/features/product/models/category.dart';
import 'package:shoplocal/features/product/models/product.dart';
import 'package:shoplocal/features/store/dao/storeDao.dart';
import 'package:shoplocal/features/store/model/store.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key, this.product});

  final Product? product;

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  List<Category> categorias = [];
  List<Store> lojas = [];
  Category? categoriaSelecionada;
  Store? lojaSelecionada;

  bool get editando => widget.product != null;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      nomeController.text = widget.product!.name;
      descricaoController.text = widget.product!.description;
      precoController.text = widget.product!.price.toString();
    }

    _carregarCategorias();
    _carregarLojas();
  }

  Future<void> _carregarCategorias() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<Category> encontrados = await CategoryDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      categorias = encontrados;

      final int? categoriaId = widget.product?.categoryId;
      if (categoriaId != null) {
        for (final Category categoria in categorias) {
          if (categoria.id == categoriaId) {
            categoriaSelecionada = categoria;
            break;
          }
        }
      }
    });
  }

  Future<void> _carregarLojas() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<Store> encontradas = await StoreDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      lojas = encontradas;

      final int? lojaId = widget.product?.storeId;
      if (lojaId != null) {
        for (final Store loja in lojas) {
          if (loja.id == lojaId) {
            lojaSelecionada = loja;
            break;
          }
        }
      }
    });
  }

  Product? _criarObjeto() {
    final String nome = nomeController.text.trim();
    final String descricao = descricaoController.text.trim();
    final double? preco = double.tryParse(
      precoController.text.trim().replaceAll(',', '.'),
    );
    final Category? categoria = categoriaSelecionada;
    final Store? loja = lojaSelecionada;

    if (nome.isEmpty ||
        descricao.isEmpty ||
        preco == null ||
        preco <= 0 ||
        categoria == null ||
        loja == null) {
      _mostrarMensagem('Informe nome, descrição, preço, categoria e loja.');
      return null;
    }

    try {
      return Product(
        id: widget.product?.id,
        name: nome,
        description: descricao,
        price: preco,
        categoryId: categoria.id,
        storeId: loja.id,
      );
    } on ArgumentError catch (erro) {
      _mostrarMensagem(erro.message as String);
      return null;
    }
  }

  Future<void> salvar() async {
    final Product? produto = _criarObjeto();

    if (produto == null) return;

    final Database banco = await Conexao.instancia.bancoDados;
    final ProductDao dao = ProductDao(banco);

    if (editando) {
      await dao.alterar(produto);
    } else {
      await dao.inserir(produto);
    }

    if (!mounted) return;

    Navigator.of(context).pop(true);
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    precoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Alterar produto' : 'Cadastrar produto'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome do produto',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descricaoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descrição',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: precoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Preço',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Categoria',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            child: DropdownButton<Category>(
              value: categoriaSelecionada,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              hint: const Text('Selecione a categoria'),
              items: [
                for (final Category categoria in categorias)
                  DropdownMenuItem<Category>(
                    value: categoria,
                    child: Text(categoria.name),
                  ),
              ],
              onChanged: (Category? valor) {
                setState(() {
                  categoriaSelecionada = valor;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Loja',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            child: DropdownButton<Store>(
              value: lojaSelecionada,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              hint: const Text('Selecione a loja'),
              items: [
                for (final Store loja in lojas)
                  DropdownMenuItem<Store>(value: loja, child: Text(loja.name)),
              ],
              onChanged: (Store? valor) {
                setState(() {
                  lojaSelecionada = valor;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: salvar,
            child: Text(editando ? 'Atualizar' : 'Inserir'),
          ),
        ],
      ),
    );
  }
}
