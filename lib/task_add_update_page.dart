import 'package:flutter/material.dart';
import 'package:local_db/common/style.dart';
import 'package:local_db/db_provider.dart';
import 'package:local_db/task.dart';
import 'package:local_db/widgets/description.dart';
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.arrow_back)),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.more_vert)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Kuliah',
                                style: textTextStyle,
                              ),
                              Icon(Icons.arrow_drop_down_outlined),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.83,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, right: 20, bottom: 200, left: 20),
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration.collapsed(hintText: ''),
                        style: blackTextStyle.copyWith(fontSize: 18),
                      ),
                    ),
                    Divider(),
                    Description(
                      title: 'Batas waktu',
                      icon: Icon(
                        Icons.calendar_today,
                        color: textColor,
                      ),
                      desc: '',
                      colorDesc: false,
                    ),
                    Divider(),
                    Description(
                      title: 'Pengingat pada',
                      icon: Icon(
                        Icons.watch_later,
                        color: textColor,
                      ),
                      desc: '5 menit sebelumnya',
                    ),
                    Description(
                      title: 'Jenis Pengingat',
                      desc: 'Notifikasi',
                    ),
                    Divider(),
                    Description(
                      title: 'Ulangi tugas',
                      icon: Icon(
                        Icons.autorenew,
                        color: textColor,
                      ),
                      desc: 'Sabtu/1 Minggu',
                    ),
                    Divider(),
                    Description(
                      title: 'Catatan',
                      icon: Icon(
                        Icons.sticky_note_2,
                        color: textColor,
                      ),
                      desc: 'TAMBAH',
                    ),
                    Divider(),
                    Description(
                      title: 'Lampiran',
                      icon: Icon(
                        Icons.attach_file,
                        color: textColor,
                      ),
                      desc: 'TAMBAH',
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
            ],
          ),
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
