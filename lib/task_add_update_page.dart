import 'package:flutter/material.dart';
import 'package:local_db/db_provider.dart';
import 'package:local_db/task.dart';
import 'package:provider/provider.dart';

class TaskAddUpdatePage extends StatefulWidget {
  final Task? task;

  TaskAddUpdatePage([this.task]);

  @override
  _TaskAddUpdatePageState createState() => _TaskAddUpdatePageState();
}

class _TaskAddUpdatePageState extends State<TaskAddUpdatePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Simpan'),
                onPressed: () async {
                  if (!_isUpdate) {
                    final task = Task(
                        title: _titleController.text,
                        description: _descriptionController.text);
                    Provider.of<DbProvider>(context, listen: false)
                        .addTask(task);
                  } else {
                    final task = Task(
                      id: widget.task!.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    Provider.of<DbProvider>(context, listen: false)
                        .updateTask(task);
                  }
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
