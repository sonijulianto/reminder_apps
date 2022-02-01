import 'package:flutter/material.dart';
import 'package:local_db/common/style.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.9,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(color: whiteColor),
    );
  }
}
