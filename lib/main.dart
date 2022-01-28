import 'package:flutter/material.dart';
import 'package:local_db/db_provider.dart';
import 'package:local_db/task_list_page.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DbProvider(),
      child: MaterialApp(
        title: 'Reminder Apps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TaskListPage(),
      ),
    );
  }
}
