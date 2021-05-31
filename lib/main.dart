import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:biblios/helpers/customColors.dart';

import 'package:biblios/screens/capitulos.dart';
import 'package:biblios/screens/form_capitulo.dart';
import 'package:biblios/screens/form_livro.dart';
import 'package:biblios/screens/livros.dart';
import 'package:biblios/screens/home.dart';

import 'package:provider/provider.dart';
import 'package:biblios/providers/capitulo_provider.dart';
import 'package:biblios/providers/livro_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LivroProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CapituloProvider(),
        )
      ],
      child: Biblios(),
    ),
  );
}

class Biblios extends StatelessWidget {
  const Biblios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblios',
      routes: {
        Home.route: (_) => Home(),
        Livros.route: (_) => Livros(),
        Capitulos.route: (_) => Capitulos(),
        FormLivro.route: (_) => FormLivro(),
        FormCapitulo.route: (_) => FormCapitulo(),
      },
      // Theming
      theme: ThemeData(
        primarySwatch: amethyst,
        appBarTheme: AppBarTheme(
          backgroundColor: amethyst,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Manrope-Bold',
            fontSize: 22,
          ),
        ),
        textTheme: TextTheme(
          // Card Title
          headline1: TextStyle(
            fontFamily: 'Manrope-Bold',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontFamily: 'Manrope-Bold',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ghostWhite,
          ),
          headline3: TextStyle(
            fontFamily: 'Manrope-Bold',
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: ghostWhite,
          ),
          headline4: TextStyle(
            fontFamily: 'Manrope-Regular',
            fontSize: 20,
          ),
          subtitle1: TextStyle(
            fontFamily: 'Manrope-SemiBold',
          ),
          subtitle2: TextStyle(
            fontFamily: 'Manrope-Bold',
            fontSize: 22,
            color: amethyst,
          ),
          bodyText1: TextStyle(
            fontFamily: 'Manrope-Regular',
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(amethyst),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(15),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              StadiumBorder(),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontFamily: 'Manrope-SemiBold',
                fontSize: 16,
              ),
            ),
          ),
        ),
        canvasColor: magnolia,
      ),
    );
  }
}
