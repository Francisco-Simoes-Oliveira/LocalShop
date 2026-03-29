import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Authform extends StatefulWidget {
  final String? tela;

  const Authform({super.key, this.tela});

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  bool isChecked = false;
  bool _obscurePassword = true;

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
                        buildField('Nome'),
                        buildField('Email'),
                        buildField('Password', obscure: true),
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
                          onPressed: () {},
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
                        const SizedBox(height: 8),
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

  Widget buildField(String tipo, {bool obscure = false}) {
    final isPassword = tipo.toLowerCase() == 'password';

    return TextField(
      obscureText: isPassword ? _obscurePassword : obscure,
      decoration: InputDecoration(
        hintText: tipo,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
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
