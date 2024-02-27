import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:atividade_rotas/data/atividade_dao.dart';

Future<Database> getDatabase() async
{
  final String  path = join(await getDatabasesPath(), 'atividade.db');
  return openDatabase(path, onCreate: (db, version){
    db.execute(AtividadeDao.tableSql);
  },version: 1,);
}
