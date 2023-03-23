import 'package:flutter/material.dart';

import '../../../../models/address_model.dart';
import 'key_text.dart';

class AddressDetailsTable extends StatelessWidget {
  const AddressDetailsTable({Key? key, this.addressModel}) : super(key: key);
  final AddressModel? addressModel;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(10),
      width: screenWidth * 0.8,
      child: Table(
        children: [
          detailsRow(title: "Name", data: addressModel!.name),
          detailsRow(title: "Phone Number", data: addressModel!.phoneNumber),
          detailsRow(title: "Home Number", data: addressModel!.homeNumber),
          detailsRow(title: "City", data: addressModel!.city),
          detailsRow(title: "State", data: addressModel!.state),
          detailsRow(title: "Pin code", data: addressModel!.pinCode),
        ],
      ),
    );
  }

  TableRow detailsRow({String? title, String? data}) {
    return TableRow(children: [KeyText(msg: title), Text(data!)]);
  }
}
