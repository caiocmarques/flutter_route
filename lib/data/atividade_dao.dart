import 'package:sqflite/sqflite.dart';
import 'package:atividade_rotas/components/atividades.dart';
import 'package:atividade_rotas/data/database.dart';

class AtividadeDao {
  static const String tableSql =
      'CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY AUTOINCREMENT, $_name TEXT)';

  static const String _tableName = 'atividadeTable';
  static const String _id = 'id';
  static const String _name = 'name';

  Future<int> save(Atividade atividade) async {
    final Database database = await getDatabase();

    final List<Atividade> existingActivities = await find(atividade.id);
    final bool activityExists = existingActivities.isNotEmpty;

    if (!activityExists) {
      return await database.insert(_tableName, toMap(atividade));
    } else {
      return await update(atividade);
    }
  }

  Map<String, dynamic> toMap(Atividade atividade) {
    return {
      _id: atividade.id,
      _name: atividade.name,
    };
  }

  Future<List<Atividade>> findAll() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tableName);
    return toList(result);
  }

  List<Atividade> toList(List<Map<String, dynamic>> result) {
    return result.map((map) => Atividade(map[_id], map[_name])).toList();
  }

  Future<List<Atividade>> find(int idDaAtividade) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tableName,
      where: '$_id = ?',
      whereArgs: [idDaAtividade],
    );
    return toList(result);
  }

  Future<int> delete(int idDaAtividade) async {
    final Database database = await getDatabase();
    return await database.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [idDaAtividade],
    );
  }

  Future<int> update(Atividade atividade) async {
    final Database database = await getDatabase();
    return await database.update(
      _tableName,
      toMap(atividade),
      where: '$_id = ?',
      whereArgs: [atividade.id],
    );
  }
  Future<int> updateName(int id, String newName) async {
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.update(
      _tableName,
      {_name: newName},
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

}