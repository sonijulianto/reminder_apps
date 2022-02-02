import 'package:flutter/material.dart';
import 'package:local_db/common/style.dart';
import 'package:local_db/db_provider.dart';
import 'package:local_db/pages/task_add_update_page.dart';
import 'package:local_db/widgets/bottom_sheet.dart';
import 'package:provider/provider.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Semua',
                              style: whiteTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Semua',
                              style: whiteTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Semua',
                              style: whiteTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Semua',
                              style: whiteTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  child: Icon(
                    Icons.more_vert,
                    color: textColor,
                  ),
                )
              ],
            ),
            Consumer<DbProvider>(
              builder: (context, provider, child) {
                final tasks = provider.tasks;
                return Expanded(
                  child: ListView.builder(
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
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          color: Colors.blue.shade50,
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Row(
                              children: [
                                Text(
                                  '01/11 07:05',
                                  style: textTextStyle.copyWith(fontSize: 12),
                                ),
                                Icon(
                                  Icons.notifications,
                                  color: textColor,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.attach_file,
                                  color: textColor,
                                  size: 15,
                                ),
                              ],
                            ),
                            onTap: () async {
                              final selectedTask =
                                  await provider.getTaskById(task.id!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TaskAddUpdatePage(task: selectedTask),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: BottomSheetTask(),
                ),
              ),
            );
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => TaskAddUpdatePage()));
          },
        ),
      ),
    );
  }
}
