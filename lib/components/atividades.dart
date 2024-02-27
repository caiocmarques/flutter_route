import 'package:flutter/material.dart';

class Atividade extends StatelessWidget {
  final int id;
  final String name;

  const Atividade(this.id, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.check),
        title: Text(name),
      ),
    );
  }
}


