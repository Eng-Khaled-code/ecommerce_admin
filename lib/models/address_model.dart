import 'package:cloud_firestore/cloud_firestore.dart';
import '../references/address_ref.dart';

class AddressModel {
  String? id;
  String? name;
  String? phoneNumber;
  String? homeNumber;
  String? city;
  String? state;
  String? pinCode;

  Map<String,dynamic>? addressMap;
  AddressRef addressRef=AddressRef();


  AddressModel();

  Map<String,dynamic> toMap(String? name, String?phoneNumber, String?homeNumber,String?city,
      String?state, String?pinCode){
    return
      {
        addressRef.name:name,
        addressRef.phoneNumber:phoneNumber,
        addressRef.homeNumber:homeNumber,
        addressRef.city:city,
        addressRef.state:state,
        addressRef.pinCode:pinCode
      };
  }


  AddressModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String,dynamic> addressData = snapshot.data() as Map<String,dynamic>;
    id = snapshot.id;
    name = addressData[addressRef.name];
    phoneNumber = addressData[addressRef.phoneNumber];
    homeNumber = addressData[addressRef.homeNumber];
    city = addressData[addressRef.city];
    state = addressData[addressRef.state];
    pinCode = addressData[addressRef.pinCode];

  }

}
