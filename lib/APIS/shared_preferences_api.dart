import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_flutter/models/todomodel.dart';

const key = 'todo_list';

class shared_pref_api {
  Future<List<todomodel>> getList() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    final jsonString = sf.getString(key) ?? '[]';
    final jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded
        .map((e) => todomodel.fromjson(e as Map<String, dynamic>))
        .toList();
  }

  void saveList(List<todomodel> todos) async {
    final stringJson = json.encode(todos.map((e) => e.tojson()).toList());
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString(key, stringJson);
  }

  void updateList(List<todomodel> todos, int id, String title, String date,
      String description) async {
    for (var i in todos) {
      if (i.id == id) {
        i.title = title;
        i.date = date;
        i.description = description;
      }
    }
    saveList(todos);
  }
}
