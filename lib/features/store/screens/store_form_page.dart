import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:shoplocal/core/database/database.dart';
import 'package:shoplocal/features/auth/dao/userDao.dart';
import 'package:shoplocal/features/auth/model/user.dart';
import 'package:shoplocal/features/store/dao/storeDao.dart';
import 'package:shoplocal/features/store/model/store.dart';

class StoreFormPage extends StatefulWidget {
  const StoreFormPage({super.key, this.store});

  final Store? store;

  @override
  State<StoreFormPage> createState() => _StoreFormPageState();
}

class _StoreFormPageState extends State<StoreFormPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<User> usuarios = [];
  User? adminSelecionado;

  bool get editando => widget.store != null;

  @override
  void initState() {
    super.initState();

    if (widget.store != null) {
      nomeController.text = widget.store!.name;
      enderecoController.text = widget.store!.address;
      telefoneController.text = widget.store!.phone;
      emailController.text = widget.store!.email;
    }

    _carregarAdmins();
  }

  Future<void> _carregarAdmins() async {
    final Database banco = await Conexao.instancia.bancoDados;
    final List<User> encontrados = await UserDao(banco).buscarTodos();

    if (!mounted) return;

    setState(() {
      usuarios = encontrados;

      final int? adminId = widget.store?.adminId;
      if (adminId != null) {
        for (final User usuario in usuarios) {
          if (usuario.id == adminId) {
            adminSelecionado = usuario;
            break;
          }
        }
      }
    });
  }

  Store? _criarObjeto() {
    final String nome = nomeController.text.trim();
    final String endereco = enderecoController.text.trim();
    final String telefone = telefoneController.text.trim();
    final String email = emailController.text.trim();
    final User? admin = adminSelecionado;

    if (nome.isEmpty ||
        endereco.isEmpty ||
        telefone.isEmpty ||
        email.isEmpty ||
        admin == null) {
      _mostrarMensagem('Informe os dados da loja e selecione o admin.');
      return null;
    }

    try {
      return Store(
        id: widget.store?.id,
        name: nome,
        address: endereco,
        phone: telefone,
        email: email,
        adminId: admin.id!,
      );
    } on ArgumentError catch (erro) {
      _mostrarMensagem(erro.message as String);
      return null;
    }
  }

  Future<void> salvar() async {
    final Store? store = _criarObjeto();

    if (store == null) return;

    final Database banco = await Conexao.instancia.bancoDados;
    final StoreDao dao = StoreDao(banco);

    if (editando) {
      await dao.alterar(store);
    } else {
      await dao.inserir(store);
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
    enderecoController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editando ? 'Alterar loja' : 'Cadastrar loja')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome da loja',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: enderecoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Endereço',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: telefoneController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Telefone',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Admin',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
            child: DropdownButton<User>(
              value: adminSelecionado,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              hint: const Text('Selecione o admin'),
              items: [
                for (final User usuario in usuarios)
                  DropdownMenuItem<User>(
                    value: usuario,
                    child: Text(usuario.name),
                  ),
              ],
              onChanged: (User? valor) {
                setState(() {
                  adminSelecionado = valor;
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
