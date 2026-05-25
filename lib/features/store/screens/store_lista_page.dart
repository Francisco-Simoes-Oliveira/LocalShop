import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:shoplocal/core/database/database.dart';
import 'package:shoplocal/features/auth/dao/userDao.dart';
import 'package:shoplocal/features/auth/model/user.dart';
import 'package:shoplocal/features/store/dao/storeDao.dart';
import 'package:shoplocal/features/store/model/store.dart';
import 'package:shoplocal/features/store/screens/store_form_page.dart';

class StoreListaPage extends StatefulWidget {
  const StoreListaPage({super.key});

  @override
  State<StoreListaPage> createState() => _StoreListaPageState();
}

class _StoreListaPageState extends State<StoreListaPage> {
  List<Store> stores = [];
  List<User> admins = [];

  @override
  void initState() {
    super.initState();
    _carregarAdmins();
    _listar();
  }

  Future<void> _carregarAdmins() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<User> encontrados = await UserDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      admins = encontrados;
    });
  }

  Future<void> _listar() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<Store> encontradas = await StoreDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      stores = encontradas;
    });
  }

  Future<void> _excluir(int id) async {
    final Database banco = await Conexao.instancia.bancoDados;
    await StoreDao(banco).excluir(id);
    await _listar();

    if (!mounted) return;

    _mostrarMensagem('Loja excluída com sucesso');
  }

  Future<void> _abrirFormulario({Store? store}) async {
    final bool? salvou = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => StoreFormPage(store: store)));

    if (salvou == true) {
      await _listar();
      if (!mounted) return;

      _mostrarMensagem(
        store == null
            ? 'Loja cadastrada com sucesso'
            : 'Loja atualizada com sucesso',
      );
    }
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  String _descricaoAdmin(int adminId) {
    for (final User user in admins) {
      if (user.id == adminId) {
        return user.name;
      }
    }

    return 'Admin $adminId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lojas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () => _abrirFormulario(),
            icon: const Icon(Icons.add),
            label: const Text('Cadastrar loja'),
          ),
          const SizedBox(height: 12),
          Text(
            'Registros encontrados: ${stores.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final Store store in stores)
            Card(
              child: ListTile(
                title: Text(store.name),
                subtitle: Text(_descricaoAdmin(store.adminId)),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      tooltip: 'Alterar',
                      icon: const Icon(Icons.edit),
                      onPressed: () => _abrirFormulario(store: store),
                    ),
                    IconButton(
                      tooltip: 'Excluir',
                      icon: const Icon(Icons.delete),
                      onPressed: () => _excluir(store.id!),
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
