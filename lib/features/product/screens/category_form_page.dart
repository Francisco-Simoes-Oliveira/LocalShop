import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:shoplocal/core/database/database.dart';
import 'package:shoplocal/features/product/dao/categoryDao.dart';
import 'package:shoplocal/features/product/models/category.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key, this.category});

  final Category? category;

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  bool get editando => widget.category != null;

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      nomeController.text = widget.category!.name;
      descricaoController.text = widget.category!.descricao;
    }
  }

  Category? _criarObjeto() {
    final String nome = nomeController.text.trim();
    final String descricao = descricaoController.text.trim();

    if (nome.isEmpty || descricao.isEmpty) {
      _mostrarMensagem('Informe nome e descrição.');
      return null;
    }

    try {
      return Category(
        id: widget.category?.id,
        name: nome,
        descricao: descricao,
      );
    } on ArgumentError catch (erro) {
      _mostrarMensagem(erro.message as String);
      return null;
    }
  }

  Future<void> salvar() async {
    final Category? category = _criarObjeto();

    if (category == null) return;

    final Database banco = await Conexao.instancia.bancoDados;
    final CategoryDao dao = CategoryDao(banco);

    if (editando) {
      await dao.alter(category);
    } else {
      await dao.incerir(category);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Alterar categoria' : 'Cadastrar categoria'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome da categoria',
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
          FilledButton(
            onPressed: salvar,
            child: Text(editando ? 'Atualizar' : 'Inserir'),
          ),
        ],
      ),
    );
  }
}
