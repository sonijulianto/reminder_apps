import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_db/common/style.dart';
import 'package:local_db/db_provider.dart';
import 'package:local_db/models/task.dart';
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
  DateTime? date;
  TimeOfDay? time;
  String? _kategori;
  List<String> hours = [];
  List<String> minutes = [];
  List<String> listKategori = [
    'Tidak ada kategori',
    'Kantor',
    'Kuliah',
    'Tugas'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      date = DateTime.parse(widget.task!.date);
      hours.add(widget.task!.time.split("")[10]);
      hours.add(widget.task!.time.split("")[11]);
      minutes.add(widget.task!.time.split("")[13]);
      minutes.add(widget.task!.time.split("")[14]);
      time = TimeOfDay(
        hour: int.parse(hours.join()),
        minute: int.parse(minutes.join()),
      );
      _isUpdate = true;
    }
  }

  String getTextTime() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  String getTextDate() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
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
                height: MediaQuery.of(context).size.height * 0.15,
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
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(10),
                              style: textTextStyle.copyWith(fontSize: 12),
                              value: _kategori,
                              items: listKategori
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _kategori = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.81,
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
                      desc: getTextDate(),
                      onTap: () {
                        pickDate(context);
                      },
                    ),
                    Divider(),
                    Description(
                      title: 'Pengingat pada jam',
                      icon: Icon(
                        Icons.watch_later,
                        color: textColor,
                      ),
                      desc: getTextTime(),
                      onTap: () {
                        pickTime(context);
                      },
                    ),
                    Description(
                      title: 'Jenis Pengingat',
                      desc: 'Notifikasi',
                      onTap: () {},
                    ),
                    Divider(),
                    Description(
                      title: 'Ulangi tugas',
                      icon: Icon(
                        Icons.autorenew,
                        color: textColor,
                      ),
                      desc: 'Sabtu/1 Minggu',
                      onTap: () {},
                    ),
                    Divider(),
                    Description(
                      title: 'Catatan',
                      icon: Icon(
                        Icons.sticky_note_2,
                        color: textColor,
                      ),
                      desc: 'TAMBAH',
                      onTap: () {},
                    ),
                    Divider(),
                    Description(
                      title: 'Lampiran',
                      icon: Icon(
                        Icons.attach_file,
                        color: textColor,
                      ),
                      desc: 'TAMBAH',
                      onTap: () {},
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Simpan'),
                        onPressed: () async {
                          if (!_isUpdate) {
                            final task = Task(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              date: date!.toIso8601String(),
                              time: time.toString(),
                            );
                            Provider.of<DbProvider>(context, listen: false)
                                .addTask(task);
                          } else {
                            final task = Task(
                              id: widget.task!.id,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              date: date!.toIso8601String(),
                              time: time.toString(),
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

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  Future pickTime(BuildContext context) async {
    final initialTime =
        TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );
    print(newTime);

    if (newTime == null) return;

    setState(() => time = newTime);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
