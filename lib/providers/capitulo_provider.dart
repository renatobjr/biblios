import 'dart:convert';
import 'package:biblios/models/capitulo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CapituloProvider with ChangeNotifier {
  List<Capitulo> capitulos = [];

  final baseUrl = 'http://192.168.1.6:3000/capitulos';
  //final baseUrl = 'http://192.168.27.112:3000/capitulos';

  // ignore: missing_return
  Future<Capitulo?> fetchAllCapitulos() async {
    final res = await http.get(Uri.parse('$baseUrl/lista'));

    if (res.statusCode == 200) {
      Iterable capitulosRes = json.decode(res.body);
      capitulos = capitulosRes
          .map(
            (json) => Capitulo.fromJson(json),
          )
          .toList();
      notifyListeners();
    } else {
      throw Exception('Não foi possível carregar a lista de capitulos');
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

    print(res.body);

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
}
