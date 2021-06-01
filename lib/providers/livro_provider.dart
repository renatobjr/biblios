import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:biblios/models/livro.dart';

class LivroProvider with ChangeNotifier {
  List<Livro> livros = [];

  final baseUrl = 'http://192.168.1.6:3000/livros';
  //final baseUrl = 'http://192.168.27.112:3000/livros';

  Future<bool?> fetchAllLivros() async {
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/lista'),
      );
      Iterable livrosRes = json.decode(res.body);
      livros = livrosRes
          .map(
            (json) => Livro.fromJson(json),
          )
          .toList();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Livro> createLivro(String titulo, String autor) async {
    final res = await http.post(
      Uri.parse('$baseUrl/novo'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'titulo': titulo,
          'autor': autor,
        },
      ),
    );

    if (res.statusCode == 200) {
      notifyListeners();
      return Livro.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Falha ao criar');
    }
  }

  Livro getById(int id) {
    return livros.firstWhere((l) => l.idLivro == id);
  }

  Future<List> countCapsLivros() async {
    final res = await http.get(
      Uri.parse('$baseUrl/total-caps'),
    );

    if (res.statusCode == 200) {
      notifyListeners();
      return jsonDecode(res.body);
    } else {
      throw Exception('Erro');
    }
  }

  Future<Livro> updateLivro(int idlivro, String titulo, String autor) async {
    final res = await http.put(
      Uri.parse('$baseUrl/atualizar/$idlivro'),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'titulo': titulo,
          'autor': autor,
        },
      ),
    );

    if (res.statusCode == 200) {
      notifyListeners();
      return Livro.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Falha ao atualizar');
    }
  }

  Future<void> delete([int? idlivro]) async {
    final res = await http.delete(Uri.parse('$baseUrl/deletar/$idlivro'));

    if (res.statusCode == 200) {
      notifyListeners();
      livros.removeWhere((l) => l.idLivro == idlivro);
    }
  }
}
