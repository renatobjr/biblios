import 'package:biblios/screens/form_capitulo.dart';
import 'package:flutter/material.dart';
import 'package:biblios/widgets/app_drawer.dart';
import 'package:biblios/widgets/list_capitulos.dart';

class Capitulos extends StatelessWidget {
  const Capitulos({Key? key}) : super(key: key);

  static const route = '/capitulos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capítulos'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, FormCapitulo.route),
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: ListCapitulos(),
      ),
    );
  }
}
