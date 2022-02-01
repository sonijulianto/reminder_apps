import 'package:flutter/material.dart';
import 'package:local_db/common/style.dart';

class Description extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String desc;
  final bool colorDesc;
  final Function() onTap;
  Description({
    Key? key,
    this.icon,
    required this.title,
    required this.desc,
    this.colorDesc = true,
    required this.onTap,
  }) : super(key: key);


  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        onPrimary: Color(0xffababab),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon != null ? icon! : SizedBox(width: 25),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: textTextStyle,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colorDesc ? Colors.blue.shade50 : Colors.transparent,
              ),
              child: Text(
                desc,
                style: textTextStyle.copyWith(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
