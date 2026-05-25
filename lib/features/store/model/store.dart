class Store {
  Store({
    this.id,
    required name,
    required address,
    required phone,
    required email,
    required this.adminId,
  }) : name = name.trim().toUpperCase(),
       address = address.trim(),
       phone = phone.trim(),
       email = email.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError('O nome e Obrigatorio');
    }
    if (this.address.isEmpty) {
      throw ArgumentError('O endereço e Obrigatorio');
    }
    if (this.phone.isEmpty) {
      throw ArgumentError('O telefone e Obrigatorio');
    }
    if (this.email.isEmpty) {
      throw ArgumentError('O email e Obrigatorio');
    }
    if (adminId <= 0) {
      throw ArgumentError('O AdminId e Obrigatorio');
    }
  }

  final int? id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final int adminId;

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] as int,
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      adminId: map['AdminId'] as int,
    );
  }

  Map<String, dynamic> toMap({incluirID = false}) {
    return {
      if (incluirID && id != null) 'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'adminId': adminId,
    };
  }
}
