import 'package:biblios/helpers/customColors.dart';
import 'package:biblios/models/livro.dart';
import 'package:biblios/screens/form_livro.dart';
import 'package:biblios/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biblios/providers/livro_provider.dart';

enum ListLivrosTipo { grid, list }

class ListLivros extends StatefulWidget {
  ListLivros({
    Key? key,
    required this.typeList,
  }) : super(key: key);

  final ListLivrosTipo typeList;

  @override
  _ListLivrosState createState() => _ListLivrosState(typeList);
}

class _ListLivrosState extends State<ListLivros> {
  final ListLivrosTipo mode;
  final double cardSize = 170;

  _ListLivrosState(this.mode);

  @override
  void initState() {
    Provider.of<LivroProvider>(context, listen: false).fetchAllLivros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final livros = Provider.of<LivroProvider>(context).livros;
    double height = MediaQuery.of(context).size.height;

    livros.sort(
      (a, b) => a.autor!.compareTo(b.autor as String),
    );
    return livros.isEmpty
        ? Padding(
            padding: EdgeInsets.only(top: height * 0.23),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Vamos iniciar cadastrando um Livro?',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      FormLivro.route,
                      arguments: {'title': 'add'},
                    ),
                    child: Text('Adicionar Livro'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Dica: Após inserir um Livro você poderá incluir Capítulos e gerenciar sua leitura.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                )
              ],
            ),
          )
        : livros.length == 0
            ? LinearProgressIndicator(
                color: amethyst,
              )
            : mode == ListLivrosTipo.grid
                ? GridLivro(
                    cardSize: cardSize,
                    livros: livros,
                  )
                : Container(
                    color: amethyst,
                    child: ListLivro(
                      cardSize: cardSize,
                      livros: livros,
                    ),
                  );
  }
}

class ListLivro extends StatelessWidget {
  const ListLivro({
    Key? key,
    required this.cardSize,
    required this.livros,
  }) : super(key: key);

  final double cardSize;
  final List<Livro> livros;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: magnolia,
        child: SizedBox(
          height: cardSize,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return Container(
                width: cardSize,
                child: CardLivro(
                  livros: livros,
                  index: i,
                ),
              );
            },
            itemCount: livros.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 5,
            ),
          ),
        ),
      ),
    );
  }
}

class GridLivro extends StatelessWidget {
  const GridLivro({
    Key? key,
    required this.cardSize,
    required this.livros,
  }) : super(key: key);

  final double cardSize;
  final List<Livro> livros;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: cardSize,
            child: CardLivro(
              index: index,
              livros: livros,
            ),
          );
        },
        itemCount: livros.length,
      ),
    );
  }
}

class CardLivro extends StatelessWidget {
  const CardLivro({
    Key? key,
    required this.index,
    required this.livros,
  }) : super(key: key);

  final int index;
  final List<Livro> livros;

  @override
  Widget build(BuildContext context) {
    void _deleteLivro(int idlivro) async {
      Navigator.pop(context);
      await Provider.of<LivroProvider>(context, listen: false).delete(idlivro);
      Navigator.popAndPushNamed(context, Home.route);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sushi,
          content: Text('Livro excluído com sucesso!'),
        ),
      );
    }

    void dialogDeleteLivro(Livro l) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: ghostWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            title: Text('Excluir o livro ${l.titulo}'),
            content: Text(
                'Ao excluir o Livro os Capítulos vinculados também serão apagado?'),
            actions: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () => _deleteLivro(l.idLivro as int),
                    child: Text('Apagar'),
                  )
                ],
              )
            ],
          );
        },
      );
    }

    return Card(
      color: ghostWhite,
      elevation: 2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  livros[index].autor as String,
                  style: Theme.of(context).textTheme.headline1,
                ),
                subtitle: Text(
                  livros[index].titulo as String,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          Positioned(
            top: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, FormLivro.route,
                      arguments: {
                        'title': livros[index].titulo,
                        'idlivro': livros[index].idLivro
                      }),
                  icon: Icon(
                    Icons.edit,
                    color: sushi,
                  ),
                ),
                IconButton(
                  onPressed: () => dialogDeleteLivro(livros[index]),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
