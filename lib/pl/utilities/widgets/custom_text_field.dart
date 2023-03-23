import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Function(String value)? onSave;
  final String? initialValue;
  final TextInputType? textInputType;
   CustomTextField({
    @required this.label,
    @required this.icon,
    @required this.onSave,
     this.initialValue="",
     this.textInputType=TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: TextFormField( onSaved: (value) {
            onSave!(value!);
          },
    initialValue:initialValue,
    maxLines:label=="Description"?3:1,
    keyboardType: textInputType,
    validator:(value){

      bool isNumeric(String s) {
        if (s == "") {
          return false;
        }
        return double.tryParse(s) != null;
      }


    if(value!.isEmpty)
    {
    return "please enter $label";
    }
    else if((label=="price")&&(isNumeric(value)==false||value=="0"||value=="0.0"))
    {
    return "enter valid value";

    }
    else if((label=="quantity")&&(isNumeric(value)==false||value=="0"))
    {
      return "enter valid value";

    }
    },
    decoration: InputDecoration(
                border:InputBorder.none,
                labelText: label,
                icon: Icon(
                  icon,

        )))));
  }

}