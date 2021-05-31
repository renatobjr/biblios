import 'package:biblios/models/livro.dart';
import 'package:biblios/providers/livro_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Helpers {
  static String? getDiaSemana(int dia) {
    Map<int, String> diaSemana = {
      1: 'Segunda-Feira',
      2: 'Terça-Feira',
      3: 'Quarta-Feira',
      4: 'Quinta-Feira',
      5: 'Sexta-Feira',
      6: 'Sábado',
      7: 'Domingo',
    };
    return diaSemana[dia];
  }

  static getLivroTitulo(BuildContext context, int livro) {
    List<Livro> livros = Provider.of<LivroProvider>(context).livros;
    return livros.firstWhere((l) => l.idLivro == livro);
  }
}
