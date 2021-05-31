import 'package:biblios/widgets/list_capitulos.dart';
import 'package:biblios/widgets/overview.dart';
import 'package:flutter/material.dart';
import 'package:biblios/widgets/app_drawer.dart';
import 'package:biblios/widgets/list_livros.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biblios',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      drawer: AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Overview(),
          ListLivros(
            typeList: ListLivrosTipo.list,
          ),
          ListCapitulos(),
        ],
      ),
    );
  }
}
