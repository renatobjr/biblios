import 'package:biblios/helpers/customColors.dart';
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 114,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/img/biblios.png'),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
              color: amethyst,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: ghostWhite,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(color: ghostWhite),
                    ),
                    onTap: () => Navigator.pushNamed(context, Home.route),
                  ),
                ),
                livros.length == 0
                    ? Text('')
                    : ListTile(
                        leading: Icon(
                          Icons.menu_book,
                          color: ghostWhite,
                        ),
                        title: Text(
                          'Livros',
                          style: TextStyle(color: ghostWhite),
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          Livros.route,
                          arguments: {'mode': 'grid'},
                        ),
                      ),
                livros.length == 0
                    ? Text('')
                    : ListTile(
                        leading: Icon(
                          Icons.book_rounded,
                          color: ghostWhite,
                        ),
                        title: Text(
                          'Capítulos',
                          style: TextStyle(
                            color: ghostWhite,
                          ),
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, Capitulos.route),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
