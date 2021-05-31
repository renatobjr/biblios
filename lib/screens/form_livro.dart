import 'package:biblios/helpers/customColors.dart';
import 'package:biblios/models/livro.dart';
import 'package:biblios/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:biblios/providers/livro_provider.dart';
import 'package:flutter/material.dart';

class FormLivro extends StatefulWidget {
  FormLivro({Key? key}) : super(key: key);
  static const route = '/livros/form';

  @override
  _FormLivroState createState() => _FormLivroState();
}

class _FormLivroState extends State<FormLivro> {
  Livro _novoLivro = Livro();
  final _livroKey = GlobalKey<FormState>();
  // FocusNode
  final _tituloFocus = FocusNode();
  final _autorFocus = FocusNode();

  @override
  void didChangeDependencies() {
    Map args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args['idlivro'] != null)
      _novoLivro = Provider.of<LivroProvider>(context).getById(args['idlivro']);
    super.didChangeDependencies();
  }

  void _salvarLivro() async {
    String snackMsg;
    if (_livroKey.currentState!.validate()) {
      _livroKey.currentState!.save();
      if (_novoLivro.idLivro == null) {
        await Provider.of<LivroProvider>(context, listen: false).createLivro(
          _novoLivro.titulo as String,
          _novoLivro.autor as String,
        );
        snackMsg = '${_novoLivro.titulo} salvo com sucesso.';
      } else {
        await Provider.of<LivroProvider>(context, listen: false).updateLivro(
          _novoLivro.idLivro as int,
          _novoLivro.titulo as String,
          _novoLivro.autor as String,
        );
        snackMsg = '${_novoLivro.titulo} atualizado com sucesso';
      }
      Navigator.popAndPushNamed(context, Home.route);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sushi,
          content: Text(snackMsg),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: args['title'] == 'add'
            ? Text('Novo Livro')
            : Text(
                args['title'],
              ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _livroKey,
          child: Column(
            children: [
              TextFormField(
                focusNode: _autorFocus,
                initialValue: _novoLivro.autor,
                onSaved: (value) => _novoLivro.autor = value,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_tituloFocus),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Nome do Autor',
                  icon: Icon(
                    Icons.person,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'O nome do Autor é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                focusNode: _tituloFocus,
                initialValue: _novoLivro.titulo,
                onSaved: (value) => _novoLivro.titulo = value,
                decoration: InputDecoration(
                  labelText: 'Título do Livro',
                  icon: Icon(
                    Icons.menu_book,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'O Título do Livro é obrigatório';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () => _salvarLivro(),
                  child: args['title'] == 'add'
                      ? Text('Adicionar Livro')
                      : Text('Atualizar ${_novoLivro.titulo}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
