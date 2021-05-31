import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/widgets.dart';
import 'package:biblios/helpers/customColors.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR');
    final _diaSemana = DateFormat.EEEE('pt_BR').format(DateTime.now());

    return Container(
      decoration: BoxDecoration(
        color: amethyst,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hoje é $_diaSemana,',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'vamos a nossa leitura',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
