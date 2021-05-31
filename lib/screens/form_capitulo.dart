import 'package:biblios/helpers/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:biblios/screens/home.dart';
import 'package:biblios/models/capitulo.dart';
import 'package:biblios/providers/livro_provider.dart';
import 'package:biblios/providers/capitulo_provider.dart';

class FormCapitulo extends StatefulWidget {
  FormCapitulo({Key? key}) : super(key: key);
  static const route = '/capitulos/form_capitulo';

  @override
  _FormCapituloState createState() => _FormCapituloState();
}

class _FormCapituloState extends State<FormCapitulo> {
  Capitulo _novoCapitulo = Capitulo();
  final _capituloKey = GlobalKey<FormState>();
  // FocusNode
  final _livroFocus = FocusNode();
  final _paginaFocus = FocusNode();
  final _tituloCapituloFocus = FocusNode();
  final _descricaoFocus = FocusNode();
  final _diaSemanaFocus = FocusNode();

  List<Map<String, Object>> _dropDownDiaSemana = [
    {'id': 1, 'diaSemana': 'Segunda-feira'},
    {'id': 2, 'diaSemana': 'Terça-feira'},
    {'id': 3, 'diaSemana': 'Quarta-feira'},
    {'id': 4, 'diaSemana': 'Quinta-feira'},
    {'id': 5, 'diaSemana': 'Sexta-feira'},
    {'id': 6, 'diaSemana': 'Sábado'},
    {'id': 7, 'diaSemana': 'Domingo'},
  ];

  void _salvarCapitulo() async {
    String? snackMsg;
    if (_capituloKey.currentState!.validate()) {
      _capituloKey.currentState!.save();
      if (_novoCapitulo.idCapitulo == null) {
        await Provider.of<CapituloProvider>(context, listen: false)
            .createCapitulo(
          _novoCapitulo.livro as int,
          _novoCapitulo.pagina as int,
          _novoCapitulo.tituloCapitulo as String,
          _novoCapitulo.descricao as String,
          _novoCapitulo.diaSemana as int,
          _novoCapitulo.terminado as int,
        );
        snackMsg = 'Novo Capítulo adicionado com sucesso';
      } else {
        print('ok');
      }
      Navigator.popAndPushNamed(context, Home.route);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sushi,
          content: Text(snackMsg!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final livros = Provider.of<LivroProvider>(context).livros;

    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Capítulo'),
      ),
      body: Form(
        key: _capituloKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              DropdownButtonFormField(
                autofocus: true,
                focusNode: _livroFocus,
                items: livros
                    .map((e) => DropdownMenuItem(
                          value: e.idLivro,
                          child: Text(e.titulo!),
                        ))
                    .toList(),
                value: _novoCapitulo.livro,
                onSaved: (value) => _novoCapitulo.livro = value as int?,
                onChanged: (value) {
                  setState(() {
                    value = _novoCapitulo.livro;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um livro';
                  }
                  return null;
                },
                hint: Text('Livro'),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.menu_book,
                    color: amethyst,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: amethyst,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      focusNode: _paginaFocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: _novoCapitulo.pagina.toString() == 'null'
                          ? null
                          : _novoCapitulo.pagina.toString(),
                      onSaved: (value) =>
                          _novoCapitulo.pagina = int.tryParse(value!),
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_tituloCapituloFocus),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.book,
                        ),
                        labelText: 'Página',
                      ),
                      cursorColor: amethyst,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a página';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      focusNode: _tituloCapituloFocus,
                      initialValue: _novoCapitulo.tituloCapitulo,
                      onSaved: (value) => _novoCapitulo.tituloCapitulo = value,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_descricaoFocus),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          icon: Icon(Icons.book),
                          labelText: 'Título do Capítulo'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o Título';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              TextFormField(
                focusNode: _descricaoFocus,
                initialValue: _novoCapitulo.descricao,
                onSaved: (value) => _novoCapitulo.descricao = value,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_diaSemanaFocus),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.text_snippet_rounded,
                    ),
                    labelText: 'Descreva o capítulo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe uma descrição';
                  }
                  return null;
                },
                maxLength: 200,
                minLines: 1,
                maxLines: 3,
              ),
              DropdownButtonFormField(
                focusNode: _diaSemanaFocus,
                items: _dropDownDiaSemana
                    .map(
                      (e) => DropdownMenuItem(
                        value: e['id'],
                        child: Text(
                          e['diaSemana'].toString(),
                        ),
                      ),
                    )
                    .toList(),
                value: _novoCapitulo.diaSemana,
                onSaved: (value) => _novoCapitulo.diaSemana = value as int?,
                onChanged: (value) {
                  setState(() {
                    value = _novoCapitulo.diaSemana;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um dia da semana';
                  }
                  return null;
                },
                hint: Text('Dia da Semana'),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.date_range,
                    color: amethyst,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: amethyst,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () => _salvarCapitulo(),
                  child: Text('Salvar Capítulo'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
