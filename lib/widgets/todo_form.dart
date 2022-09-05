import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/auth_service.dart';

import '../services/todo_list_service.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formTodoKey = GlobalKey<FormState>();
    String titleForm = '';
    final uid = AuthService().currentUser!.id;

    void _submit() {
      final isValid = _formTodoKey.currentState?.validate() ?? false;

      if (!isValid) {
        return;
      }

      final newTodo = TodoModel(
        id: Random().nextDouble().toString(),
        title: titleForm,
        completed: false,
        date: DateTime.now(),
      );

      FocusManager.instance.primaryFocus?.unfocus();
      Provider.of<TodoListService>(context, listen: false).addTodo(
        newTodo,
        uid,
      );
      Navigator.of(context).pop();
    }

    return Card(
      color: const Color.fromRGBO(4, 89, 165, 1),
      child: Form(
        key: _formTodoKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Add New To-do',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSans',
                  letterSpacing: 1.0,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(8, 8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (title) => titleForm = title,
                validator: (titleValidator) {
                  final title = titleValidator ?? '';

                  if (title.trim().isEmpty) {
                    return 'Please, insert the title';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      child: const Text('ADD'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
