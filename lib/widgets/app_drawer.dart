import 'package:biblios/providers/livro_provider.dart';
import 'package:biblios/screens/capitulos.dart';
import 'package:flutter/material.dart';

import 'package:biblios/screens/home.dart';
import 'package:biblios/screens/livros.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final livros = Provider.of<LivroProvider>(context).livros;

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            trailing: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushNamed(context, Home.route),
          ),
          livros.length == 0
              ? Text('')
              : ListTile(
                  trailing: Icon(Icons.menu_book),
                  title: Text('Livros'),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Livros.route,
                    arguments: {'mode': 'grid'},
                  ),
                ),
          livros.length == 0
              ? Text('')
              : ListTile(
                  trailing: Icon(Icons.book_rounded),
                  title: Text('Capítulos'),
                  onTap: () => Navigator.pushNamed(context, Capitulos.route),
                )
        ],
      ),
    );
  }
}
