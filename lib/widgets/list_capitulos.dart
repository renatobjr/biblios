import 'package:biblios/helpers/customColors.dart';
import 'package:biblios/helpers/helpers.dart';
import 'package:biblios/models/capitulo.dart';
import 'package:biblios/providers/capitulo_provider.dart';
import 'package:biblios/screens/form_capitulo.dart';
import 'package:biblios/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ListCapitulos extends StatefulWidget {
  ListCapitulos({Key? key}) : super(key: key);

  @override
  _ListCapitulosState createState() => _ListCapitulosState();
}

class _ListCapitulosState extends State<ListCapitulos> {
  @override
  void initState() {
    Provider.of<CapituloProvider>(context, listen: false).fetchAllCapitulos();
    super.initState();
  }

  void _deleteCapitulo(int idcapitulo) async {
    Navigator.pop(context);
    await Provider.of<CapituloProvider>(context, listen: false)
        .delete(idcapitulo);
    Navigator.popAndPushNamed(context, Home.route);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: sushi,
        content: Text('Capítulo excluído com sucesso!'),
      ),
    );
  }

  void dialogDeleteCapitulos(Capitulo c) {
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
          title: Text('Excluir o capítulo ${c.tituloCapitulo}'),
          content: Text('Deseja excluir permanentemente o capítulo?'),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => _deleteCapitulo(c.idCapitulo as int),
                  child: Text('Apagar'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final capitulos = Provider.of<CapituloProvider>(context).capitulos;
    capitulos.sort(
      (a, b) => a.diaSemana!.compareTo(b.diaSemana as num),
    );
    return capitulos.isEmpty
        ? Text('')
        : Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      final tituloLivro = Helpers.getLivroTitulo(
                          context, capitulos[i].livro as int);

                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, FormCapitulo.route, arguments: {
                          'title': capitulos[i].tituloCapitulo,
                          'idcapitulo': capitulos[i].idCapitulo
                        }),
                        child: Container(
                          height: 120,
                          child: Card(
                            color: ghostWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: capitulos[i].terminado == 0
                                        ? Text(
                                            '${tituloLivro?.titulo}: ${capitulos[i].tituloCapitulo}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          )
                                        : Text(
                                            'Capitulo Finalizado',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                    subtitle: Text(
                                      '${Helpers.getDiaSemana(capitulos[i].diaSemana as int)}, página ${capitulos[i].pagina}',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    leading: Switch(
                                      value: capitulos[i].terminado == 0
                                          ? false
                                          : true,
                                      onChanged: (value) {
                                        setState(() {
                                          if (value) {
                                            capitulos[i].terminado = 1;
                                            Provider.of<CapituloProvider>(
                                                    context,
                                                    listen: false)
                                                .isFinished(
                                                    capitulos[i].idCapitulo
                                                        as int,
                                                    1);
                                          } else {
                                            capitulos[i].terminado = 0;
                                            Provider.of<CapituloProvider>(
                                                    context,
                                                    listen: false)
                                                .isFinished(
                                                    capitulos[i].idCapitulo
                                                        as int,
                                                    0);
                                          }
                                        });
                                      },
                                    ),
                                    trailing: capitulos[i].terminado == 1
                                        ? IconButton(
                                            onPressed: () =>
                                                dialogDeleteCapitulos(
                                                    capitulos[i]),
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        : null,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: capitulos.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 2,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
