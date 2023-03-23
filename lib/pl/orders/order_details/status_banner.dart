import 'package:flutter/material.dart';

import '../../utilities/text_style/text_styles.dart';

// ignore: must_be_immutable
class StatusBanner extends StatelessWidget {
  final String? status;

  StatusBanner({Key? key, @required this.status}) : super(key: key);

  String? msg;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    icon = status! == "not checked"
        ? Icons.close
        : status! == "sent"
            ? Icons.more_horiz
            : Icons.done;
    msg = status! == "not checked"
        ? "you don't see this order"
        : status! == "sent"
            ? "you sent this order"
            : "Done";

    return Container(
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(color: Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [title(), SizedBox(width: 15.0), statusIcon()],
        ));
  }

  Icon statusIcon() {
    return Icon(
      icon,
      color: status! == "not checked"
          ? Colors.red
          : status! == "sent"
              ? Colors.white
              : Colors.lightGreenAccent,
      size: 33.0,
    );
  }

  title() {
    return Text(
      msg!,
      style: TextStyles.title,
    );
  }
}
