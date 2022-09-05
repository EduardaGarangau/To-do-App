import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/services/auth_service.dart';
import '../services/todo_list_service.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    final uid = AuthService().currentUser!.id;
    Provider.of<TodoListService>(context, listen: false).loadTodos(uid);
  }

  @override
  Widget build(BuildContext context) {
    final uid = AuthService().currentUser!.id;
    final items = Provider.of<TodoListService>(context).listTodo;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'My Tasks',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          '${items.length} tasks',
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'NotoSans',
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          width: 300,
          child: Divider(
            thickness: 2,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(items[index].id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  Provider.of<TodoListService>(context, listen: false)
                      .deleteTodo(items[index], uid);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: items[index].completed
                        ? const Color.fromRGBO(4, 89, 165, 1)
                        : Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            items[index].title,
                            style: TextStyle(
                              decoration: items[index].completed
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'NotoSans',
                              color: items[index].completed
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat('dd/MM/yyyy').format(items[index].date),
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              color: items[index].completed
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: InkWell(
                          onTap: () => Provider.of<TodoListService>(context,
                                  listen: false)
                              .completedTodo(uid, items[index]),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: items[index].completed
                                  ? const Color.fromRGBO(4, 89, 165, 1)
                                  : Colors.white,
                              border: Border.all(
                                color: items[index].completed
                                    ? Colors.white
                                    : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: items[index].completed
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
