import 'package:biblios/helpers/customColors.dart';
import 'package:biblios/helpers/helpers.dart';
import 'package:biblios/providers/capitulo_provider.dart';
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

                      return Container(
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
                                  title: Text(
                                    '${tituloLivro?.titulo}: ${capitulos[i].tituloCapitulo}',
                                    style:
                                        Theme.of(context).textTheme.headline1,
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
                                        } else {
                                          capitulos[i].terminado = 0;
                                        }
                                      });
                                    },
                                  ),
                                )
                              ],
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
