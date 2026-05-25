import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shoplocal/core/database/database.dart';
import 'package:shoplocal/features/auth/dao/userDao.dart';
import 'package:shoplocal/features/auth/model/user.dart';

class Authform extends StatefulWidget {
  final String? tela;

  const Authform({super.key, this.tela});

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool isChecked = false;
  bool obscurePassword = true;

  bool get isRegister => widget.tela == 'register';

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _registrarUsuario() async {
    final String nome = nomeController.text.trim();
    final String email = emailController.text.trim();
    final String senha = senhaController.text;

    if (!isChecked) {
      _mostrarMensagem('É necessário aceitar os termos para continuar.');
      return;
    }

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      _mostrarMensagem('Preencha nome, email e senha.');
      return;
    }

    try {
      final Database banco = await Conexao.instancia.bancoDados;
      final UserDao dao = UserDao(banco);
      final User usuario = User(name: nome, email: email, password: senha);

      await dao.incerir(usuario);

      if (!mounted) return;

      nomeController.clear();
      emailController.clear();
      senhaController.clear();
      setState(() {
        isChecked = false;
      });

      _mostrarMensagem('Cadastro realizado com sucesso.');
    } on ArgumentError catch (erro) {
      if (!mounted) return;

      _mostrarMensagem(erro.message as String);
    } catch (erro) {
      if (!mounted) return;

      _mostrarMensagem('Erro ao salvar usuário.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x0A000000),
                  blurRadius: 48,
                  offset: const Offset(0, 24),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              children: [
                switch (widget.tela) {
                  'login' => Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 24,
                      children: [
                        buildField('Email'),
                        buildField('Password', obscure: true),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/forgot');
                          },
                          child: const Text(
                            ' Esqueci minha senha',
                            style: TextStyle(
                              color: Color(0xFF004AC6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/dashboard');
                          },
                          child: const Text('Login'),
                        ),
                        buildDivider('Ou continuar com'),
                        buildSocialButtons(),
                      ],
                    ),
                  ),
                  'register' => Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 24,
                      children: [
                        buildField('Nome', controller: nomeController),
                        buildField('Email', controller: emailController),
                        buildField(
                          'Password',
                          controller: senhaController,
                          obscure: true,
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 220,

                                child: RichText(
                                  text: TextSpan(
                                    text: 'Aceito os ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'termos de uso',
                                        style: const TextStyle(
                                          color: Color(0xFF004AC6),
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Ação padrão, ex:
                                            Navigator.of(
                                              context,
                                            ).pushNamed('/termos');
                                          },
                                      ),
                                      const TextSpan(text: ' e '),
                                      TextSpan(
                                        text: 'políticas de privacidade',
                                        style: const TextStyle(
                                          color: Color(0xFF004AC6),
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(
                                              context,
                                            ).pushNamed('/privacidade');
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isChecked ? _registrarUsuario : null,
                          child: const Text('Registrar'),
                        ),

                        buildDivider('Ou cadastre-se com'),
                        buildSocialButtons(),
                      ],
                    ),
                  ),
                  'forgot' => Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 24,
                      children: [
                        buildField('Email'),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Enviar link de recuperação'),
                        ),
                        Divider(),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Lembrou sua senha? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed('/login');
                              },
                              child: const Text(
                                'Fazer login',
                                style: TextStyle(
                                  color: Color(0xFF004AC6),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _ => SizedBox.shrink(),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(
    String tipo, {
    TextEditingController? controller,
    bool obscure = false,
  }) {
    final isPassword = tipo.toLowerCase() == 'password';

    return TextField(
      controller: controller,
      obscureText: isPassword ? obscurePassword : obscure,
      decoration: InputDecoration(
        hintText: tipo,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget buildDivider(String texto) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(texto),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/img/google-logo.png',
            width: 24,
            height: 24,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/img/ios-logo.png', width: 24, height: 24),
        ),
      ],
    );
  }
}
