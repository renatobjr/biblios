import 'dart:convert';
import 'package:biblios/models/capitulo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CapituloProvider with ChangeNotifier {
  List<Capitulo> capitulos = [];

  final baseUrl = 'http://192.168.1.6:3000/capitulos';
  //final baseUrl = 'http://192.168.27.112:3000/capitulos';

  Future<bool?> fetchAllCapitulos() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/lista'),
      );
      Iterable capitulosRes = json.decode(res.body);
      capitulos = capitulosRes
          .map(
            (json) => Capitulo.fromJson(json),
          )
          .toList();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Capitulo> createCapitulo(int livro, int pagina, String tituloCapitulo,
      String descricao, int diaSemana, int terminado) async {
    final res = await http.post(
      Uri.parse('$baseUrl/novo'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'livro': livro,
          'pagina': pagina,
          'tituloCapitulo': tituloCapitulo,
          'descricao': descricao,
          'diaSemana': diaSemana,
          'terminado': terminado
        },
      ),
    );

    if (res.statusCode == 200) {
      notifyListeners();
      return Capitulo.fromJson(
        jsonDecode(res.body),
      );
    } else {
      print(terminado);
      throw Exception('err');
    }
  }

  Capitulo getById(int id) {
    return capitulos.firstWhere((c) => c.idCapitulo == id);
  }

  Future<Capitulo> updateCapitulo(
      int idcapitulo,
      int livro,
      int pagina,
      String tituloCapitulo,
      String descricao,
      int diaSemana,
      int terminado) async {
    final res = await http.put(
      Uri.parse('$baseUrl/atualizar/$idcapitulo'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, dynamic>{
          'livro': livro,
          'pagina': pagina,
          'tituloCapitulo': tituloCapitulo,
          'descricao': descricao,
          'diaSemana': diaSemana,
          'terminado': terminado,
        },
      ),
    );

    if (res.statusCode == 200) {
      notifyListeners();
      return Capitulo.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('falha ao atualizar');
    }
  }

  Future<void> isFinished(int idcapitulo, int terminado) async {
    final res = await http.put(
      Uri.parse('$baseUrl/terminado/$idcapitulo'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, int>{'terminado': terminado},
      ),
    );

    if (res.statusCode == 200) {
      notifyListeners();
    }
  }

  Future<void> delete(int idcapitulo) async {
    final res = await http.delete(Uri.parse('$baseUrl/deletar/$idcapitulo'));

    if (res.statusCode == 200) {
      notifyListeners();
      capitulos.removeWhere((c) => c.idCapitulo == idcapitulo);
    }
  }
}
