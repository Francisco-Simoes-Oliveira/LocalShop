class Tag {
  Tag({this.id, required String name, required String descricao})
    : name = name.trim().toUpperCase(),
      descricao = descricao.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError('O nome e Obrigatorio');
    }
    if (this.descricao.isEmpty) {
      throw ArgumentError('A descrição e obrigatoria');
    }
  }

  final int? id;
  final String name;
  final String descricao;

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as int,
      name: map['name'] as String,
      descricao: map['descricao'] as String,
    );
  }

  Map<String, dynamic> toMap({incluirID = false}) {
    return {
      if (incluirID && id != null) 'id': id,
      'name': name,
      'descricao': descricao,
    };
  }
}
