import 'package:flutter/material.dart';
import 'package:atividade_rotas/components/atividades.dart';

class AtividadeInherited extends InheritedWidget {
  final List<Atividade> atividadeList;
  final Function(String) newAtividade;

  AtividadeInherited({
    Key? key,
    required this.atividadeList,
    required this.newAtividade,
    required Widget child,
  }) : super(key: key, child: child);

  static AtividadeInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AtividadeInherited>();
  }

  @override
  bool updateShouldNotify(AtividadeInherited oldWidget) {
    return oldWidget.atividadeList.length != atividadeList.length;
  }
}
