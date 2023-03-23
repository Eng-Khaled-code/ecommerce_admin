import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {

  final String? msg;


  NotificationCard({Key? key,@required this.msg}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                msg == "No items"
                    ? Icons.add_shopping_cart
                    : msg == "Retry Search"
                    ? Icons.youtube_searched_for
                    : msg == "No Connection"
                    ? Icons.signal_cellular_connected_no_internet_4_bar
                    : Icons.featured_play_list_outlined,
                color: Colors.grey,
                size: 50.0,
              ),
              msg == "No items"
                  ? Container()
                  : msg == "Retry Search"
                  ? Text(
                "No Results",
                style: TextStyle(color: Colors.grey),
              )
                  : Container(),
              Text(msg!, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
