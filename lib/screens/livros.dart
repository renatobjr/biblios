import 'package:biblios/screens/form_livro.dart';
import 'package:flutter/material.dart';
import 'package:biblios/widgets/app_drawer.dart';
import 'package:biblios/widgets/list_livros.dart';

class Livros extends StatelessWidget {
  const Livros({Key? key}) : super(key: key);

  static const route = '/livros';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livros'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, FormLivro.route,
                arguments: {'title': 'add'}),
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListLivros(
        typeList: ListLivrosTipo.grid,
      ),
    );
  }
}
