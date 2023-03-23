import 'package:flutter/material.dart';


class KeyText extends StatelessWidget {
  final String? msg;

  KeyText({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg!,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}