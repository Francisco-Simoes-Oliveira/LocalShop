import 'dart:ffi';

abstract class Usuario {
  Long id;
  String nome;
  String email;

  Usuario(this.id, this.nome, this.email);
}
