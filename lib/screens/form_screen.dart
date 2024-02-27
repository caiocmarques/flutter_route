import 'package:flutter/material.dart';
import 'package:atividade_rotas/components/atividades.dart';
import 'package:atividade_rotas/data/atividade_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.atividadeContext}) : super(key: key);

  final BuildContext atividadeContext;
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController atividadeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    return value != null && value.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Atividade'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/dashboard");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: atividadeController,
                decoration: InputDecoration(
                  labelText: 'Atividade',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (valueValidator(value)) {
                    return 'Por favor, insira uma atividade.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String atividade = atividadeController.text;
                    int result = await AtividadeDao().save(Atividade(0, atividade));
                    if (result > 0) {
                      atividadeController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Atividade adicionada com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (route) => false);
                      print('Atividade adicionada: $atividade');
                    } else {
                      print('Erro ao adicionar atividade');
                    }
                  }
                },
                child: Text('Adicionar Atividade'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}