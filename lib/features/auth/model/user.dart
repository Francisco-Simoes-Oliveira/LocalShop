class User {
  User({
    this.id,
    required String name,
    required String email,
    required String password,
  }) : name = name.trim(),
       email = email.trim(),
       password = password {
    if (this.name.isEmpty) {
      throw ArgumentError('Nome e Obrigatório');
    }
    if (this.email.isEmpty) {
      throw ArgumentError('Email e Obrigatório');
    }
    if (this.password.isEmpty) {
      throw ArgumentError('Senha e Obrigatório');
    }
  }
  final int? id;
  final String name;
  final String email;
  final String password;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  Map<String, dynamic> toMap({bool incluirId = false}) {
    return {
      if (incluirId && id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
