import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_db/common/style.dart';
import 'package:local_db/db_provider.dart';
import 'package:local_db/models/task.dart';
import 'package:provider/provider.dart';

class BottomSheetTask extends StatefulWidget {
  final Task? task;

  BottomSheetTask({this.task});
  @override
  State<BottomSheetTask> createState() => _BottomSheetTaskState();
}

class _BottomSheetTaskState extends State<BottomSheetTask> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _titleController,
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: bold,
              ),
              autofocus: true,
              decoration: InputDecoration.collapsed(
                  hintText: 'Masukan tugas baru disini',
                  hintStyle: textTextStyle.copyWith(fontSize: 20)),
              onChanged: (newText) {},
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Tidak Ada Kategori',
                    style: textTextStyle.copyWith(fontSize: 11),
                  ),
                ),
                Icon(
                  Icons.event,
                  color: Colors.green.shade800,
                  size: 20,
                ),
                Icon(
                  Icons.account_tree_rounded,
                  color: textColor,
                  size: 20,
                ),
                Icon(
                  Icons.event_available,
                  color: textColor,
                  size: 20,
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    onPressed: () async {
                      final task = Task(
                        title: _titleController.text,
                        description: _titleController.text,
                        date: 'Select Date',
                        time: 'Select Time',
                      );
                      Provider.of<DbProvider>(context, listen: false)
                          .addTask(task);
                      _titleController.clear();
                    },
                    child: Icon(
                      Icons.send_rounded,
                      color: whiteColor,
                      size: 18,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
