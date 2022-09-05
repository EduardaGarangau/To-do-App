import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoListService with ChangeNotifier {
  final String urlDataBase =
      'https://todoapp-ed205-default-rtdb.firebaseio.com';
  List<TodoModel> _listTodo = [];

  List<TodoModel> get listTodo => [..._listTodo];

  Future<void> loadTodos(String uid) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();

    _listTodo.clear();

    final response =
        await http.get(Uri.parse('$urlDataBase/$uid/todos.json?auth=$token'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((todoId, todoData) {
      _listTodo.add(
        TodoModel(
          id: todoId,
          title: todoData['title'],
          date: DateTime.parse(todoData['date']),
          completed: todoData['completed'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addTodo(TodoModel todo, String uid) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final response =
        await http.post(Uri.parse('$urlDataBase/$uid/todos.json?auth=$token'),
            body: jsonEncode({
              'title': todo.title,
              'date': todo.date.toIso8601String(),
              'completed': todo.completed,
            }));
    final id = jsonDecode(response.body)['name'];
    _listTodo.insert(
      0,
      TodoModel(
        id: id,
        title: todo.title,
        completed: todo.completed,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> deleteTodo(TodoModel todo, String uid) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    int index = _listTodo.indexWhere((item) => item.id == todo.id);
    if (index >= 0) {
      final item = _listTodo[index];
      _listTodo.remove(item);
      notifyListeners();

      await http.delete(
          Uri.parse('$urlDataBase/$uid/todos/${todo.id}.json?auth=$token'));
    }
  }

  Future<void> deleteAllTodos(String uid) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    await http.delete(Uri.parse('$urlDataBase/$uid/todos.json?auth=$token'));
    _listTodo.clear();
    notifyListeners();
  }

  Future<void> completedTodo(String uid, TodoModel todoModel) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    bool completed = todoModel.completed;
    todoModel.completed = !completed;
    notifyListeners();

    await http.patch(
      Uri.parse('$urlDataBase/$uid/todos/${todoModel.id}.json?auth=$token'),
      body: jsonEncode({
        'completed': todoModel.completed,
      }),
    );
  }
}
