import 'package:flutter/material.dart';
import 'package:local_db/db_provider.dart';
import 'package:local_db/task_add_update_page.dart';
import 'package:provider/provider.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<DbProvider>(
          builder: (context, provider, child) {
            final tasks = provider.tasks;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  key: Key(task.id.toString()),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    provider.deleteTask(task.id!);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      onTap: () async {
                        final selectedTask =
                            await provider.getTaskById(task.id!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TaskAddUpdatePage(selectedTask),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TaskAddUpdatePage()));
          },
        ),
      ),
    );
  }
}
