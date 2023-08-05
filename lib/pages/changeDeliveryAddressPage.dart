import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class changeDeliveryAddress extends StatefulWidget {
  const changeDeliveryAddress({super.key});

  @override
  State<changeDeliveryAddress> createState() => _changeDeliveryAddressState();
}

class _changeDeliveryAddressState extends State<changeDeliveryAddress> {
  TextEditingController controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<e_commerceProvider>(context, listen: false);
    provider.getUser();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        title: smallText(text: "Change Delivery Address"),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Consumer<e_commerceProvider>(builder: (context, value, child) {
        if(value.myUser.isEmpty){
          return CircularProgressIndicator();
        }
        else{
        controller.text=value.myUser[0].name;
        phoneController.text=value.myUser[0].phone!;
        addressController.text=value.myUser[0].deliveryAddress!;
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          myInputField("Name", controller),
          SizedBox(height: 5,),
          myInputField("Phone", phoneController),
          SizedBox(height: 5,),
          myInputField("Address", addressController),
          SizedBox(height: 5,),
          TextButton(onPressed: (){
value.updateUser(value.myUser[0].id!, controller.text, addressController.text,phoneController.text);
          }, child: smallText(text: "Update",color: Colors.white,),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue
          ),
          )
          ],
        );
        }
      }),
    );
  }
  Widget myInputField(String text,TextEditingController controller){
    return    Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(left: 3, right: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                controller: controller,
                decoration: InputDecoration(
                  prefixIconColor: Colors.black,
                  
                  hintText: text,
                  border: InputBorder.none,
                ),
              ),
            );
  }
}
