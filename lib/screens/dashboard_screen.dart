import 'package:flutter/material.dart';
import 'package:atividade_rotas/components/atividades.dart';
import 'package:atividade_rotas/data/atividade_dao.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<Atividade>> _atividadesFuture;

  @override
  void initState() {
    super.initState();
    _atividadesFuture = AtividadeDao().findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _atividadesFuture = AtividadeDao().findAll();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: Text('Minhas atividades'),
      ),
      drawer: Drawer(
        child: Container(
          height: 650,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  radius: 55.0,
                  backgroundImage: AssetImage('assets/'),
                ),
                accountName: Text('Caio Marques'),
                accountEmail: Text('caiocmarques@gmail.com'),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () => onButtonSairClicked(context),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Atividade>>(
          future: _atividadesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar atividades'),
              );
            } else if (snapshot.hasData) {
              final List<Atividade> items = snapshot.data!;
              if (items.isNotEmpty) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Atividade atividade = items[index];
                    return ListTile(
                      title: Text(atividade.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _deleteAtividade(context, atividade);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              _editarAtividade(context, atividade);
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.error_outline, size: 128,),
                      Text(
                        'Não há nenhuma Atividade',
                        style: TextStyle(fontSize: 32),
                      )
                    ],
                  ),
                );
              }
            }
            return Center(
              child: Text('Carregando...'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onButtonAddAtividadeClicked(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void onButtonAddAtividadeClicked(BuildContext context) {
    Navigator.pushNamed(context, "/addAtividade");
  }

  void onButtonSairClicked(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  void _deleteAtividade(BuildContext context, Atividade atividade) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar exclusão"),
          content: Text("Tem certeza de que deseja excluir esta atividade?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                await AtividadeDao().delete(atividade.id);
                setState(() {
                  _atividadesFuture = AtividadeDao().findAll();
                });
                Navigator.of(context).pop();
              },
              child: Text("Excluir"),
            ),
          ],
        );
      },
    );
  }


  void _editarAtividade(BuildContext context, Atividade atividade) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _controller = TextEditingController(text: atividade.name);

        return AlertDialog(
          title: Text("Editar atividade"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Novo nome da atividade'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                String novoNome = _controller.text;
                if (novoNome.isNotEmpty) {
                  await AtividadeDao().updateName(atividade.id, novoNome);
                  setState(() {
                    _atividadesFuture = AtividadeDao().findAll();
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('O nome não pode ser vazio.'),
                    ),
                  );
                }
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }



}
