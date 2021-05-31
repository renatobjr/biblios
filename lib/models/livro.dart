class Livro {
  int? idLivro;
  String? autor, titulo;

  Livro({
    this.idLivro,
    this.autor,
    this.titulo,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      idLivro: json['idlivro'],
      autor: json['autor'],
      titulo: json['titulo'],
    );
  }
}
