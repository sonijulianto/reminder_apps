import 'package:flutter/material.dart';
import 'package:local_db/functions/menghitung_jam_pengingat.dart';
import 'package:local_db/pages/task_add_update_page.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<bool> isChecked = [false, true, false, false, false, false, false];
  bool isSwitched = false;
  bool canUpload = false;
  List<String> _texts = [
    "Sama dengan tanggal jatuh tempo",
    "5 menit sebelumnya",
    "10 menit sebelumnya",
    "15 menit sebelumnya",
    "30 menit sebelumnya",
    "1 hari sebelumnya",
    "2 hari sebelumnya",
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Pengingat aktif'),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _texts.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(_texts[index]),
                    value: isChecked[index],
                    onChanged: (value) {
                      setState(() {
                        isChecked[index] = value!;
                        canUpload = true;
                        print(isChecked);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              returnPengingat(isChecked);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskAddUpdatePage(
                            isChecked: isChecked,
                          )));
            },
            child: Text('Terapkan'),
          ),
        )
      ],
    );
  }

  returnPengingat(List<bool> isChecked) {
    if (isChecked[1]) {
      print(TaskAddUpdatePage.time!.hour);
      print(beforeFiveMin(
          TaskAddUpdatePage.time!.hour, TaskAddUpdatePage.time!.hour));
    }
  }
}
