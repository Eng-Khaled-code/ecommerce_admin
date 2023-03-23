import 'package:flutter/material.dart';

import '../../utilities/strings.dart';
import '../../utilities/text_style/text_styles.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({Key? key, this.label, this.icon, this.counter})
      : super(key: key);
  final String? label;
  final IconData? icon;
  final String? counter;

  @override
  Widget build(BuildContext context) {
    return label == Strings.revenue
        ? listTile()
        : Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(elevation: 4.0, child: Center(child: listTile())),
          );
  }

  ListTile listTile() {
    return ListTile(title: labelAndIconWidget(), subtitle: count());
  }

  TextButton labelAndIconWidget() {
    return TextButton.icon(
      onPressed: null,
      icon: Icon(icon, size: 40, color: Colors.blue),
      label: SizedBox(
        width: 80,
        child: Text(label!,
            textAlign: TextAlign.center,
            style: TextStyles.title.copyWith(color: Colors.blue)),
      ),
    );
  }

  Text count() {
    return Text(counter!,
        textAlign: TextAlign.center,
        style: TextStyles.title.copyWith(color: Colors.blue));
  }
}
