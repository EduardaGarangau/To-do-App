import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/services/todo_list_service.dart';
import 'package:todo_app/widgets/drawer_app.dart';
import 'package:todo_app/widgets/todo_form.dart';
import 'package:todo_app/widgets/todo_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  // Abrir Modal do formulário para adicionar To-do
  // a partir do FloatingButton
  openTodoForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const TodoForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = AuthService().currentUser!.id;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () =>
                Provider.of<TodoListService>(context, listen: false)
                    .deleteAllTodos(uid),
          ),
        ],
      ),
      drawer: const DrawerApp(),
      body: const TodoList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: const Color.fromRGBO(4, 89, 165, 1),
          onPressed: () => openTodoForm(context),
        ),
      ),
    );
  }
}
