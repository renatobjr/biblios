class Capitulo {
  int? idCapitulo, livro, diaSemana, pagina, terminado;
  String? tituloCapitulo, descricao;

  Capitulo({
    this.idCapitulo,
    this.livro,
    this.pagina,
    this.tituloCapitulo,
    this.descricao,
    this.diaSemana,
    this.terminado = 0,
  });

  factory Capitulo.fromJson(Map<String, dynamic> json) {
    return Capitulo(
      idCapitulo: json['idcapitulo'],
      livro: json['livro'],
      pagina: json['pagina'],
      tituloCapitulo: json['tituloCapitulo'],
      descricao: json['descricao'],
      diaSemana: json['diaSemana'],
      terminado: json['terminado'],
    );
  }
}
