import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:shoplocal/core/database/database.dart';
import 'package:shoplocal/features/product/dao/categoryDao.dart';
import 'package:shoplocal/features/product/models/category.dart';
import 'package:shoplocal/features/product/screens/category_form_page.dart';

class CategoryListaPage extends StatefulWidget {
  const CategoryListaPage({super.key});

  @override
  State<CategoryListaPage> createState() => _CategoryListaPageState();
}

class _CategoryListaPageState extends State<CategoryListaPage> {
  List<Category> categorias = [];

  @override
  void initState() {
    super.initState();
    _listar();
  }

  Future<void> _listar() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<Category> encontradas = await CategoryDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      categorias = encontradas;
    });
  }

  Future<void> _excluir(int id) async {
    final Database banco = await Conexao.instancia.bancoDados;
    await CategoryDao(banco).excluir(id);
    await _listar();

    if (!mounted) return;

    _mostrarMensagem('Categoria excluída com sucesso');
  }

  Future<void> _abrirFormulario({Category? category}) async {
    final bool? salvou = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CategoryFormPage(category: category)),
    );

    if (salvou == true) {
      await _listar();
      if (!mounted) return;

      _mostrarMensagem(
        category == null
            ? 'Categoria cadastrada com sucesso'
            : 'Categoria atualizada com sucesso',
      );
    }
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () => _abrirFormulario(),
            icon: const Icon(Icons.add),
            label: const Text('Cadastrar categoria'),
          ),
          const SizedBox(height: 12),
          Text(
            'Registros encontrados: ${categorias.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final Category category in categorias)
            Card(
              child: ListTile(
                title: Text(category.name),
                subtitle: Text(category.descricao),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      tooltip: 'Alterar',
                      icon: const Icon(Icons.edit),
                      onPressed: () => _abrirFormulario(category: category),
                    ),
                    IconButton(
                      tooltip: 'Excluir',
                      icon: const Icon(Icons.delete),
                      onPressed: () => _excluir(category.id!),
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
