import 'package:e_commerce/controller/loginController.dart';
import 'package:e_commerce/model/constraints.dart';
import 'package:e_commerce/provider/providers.dart';
import 'package:e_commerce/utils/mediumText.dart';
import 'package:e_commerce/utils/smallText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController? controller;
  TextEditingController? passwordController;
  TextEditingController?phoneController;
  bool isInValid = false;
  final formState = GlobalKey<FormState>();
  login? loginController;
  @override
  void initState() {
    // TODO: implement initState
    loginController = login();
    controller = new TextEditingController();
    passwordController = TextEditingController();
    phoneController=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    passwordController!.dispose();
    phoneController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: deviceUtils.getDeviceHeight(context),
        child: Form(
          key: formState,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: [
              mediumText(text: "Login", color: Colors.black),
              SizedBox(
                height: 8,
              ),
              IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                languageCode: "en",
                onChanged: (phone) {
                  debugPrint(phone.completeNumber);
                },
                onCountryChanged: (country) {
                  debugPrint('Country changed to: ' + country.name);
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black)),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      isInValid = true;
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  controller: controller,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Text("FullName"),
                    prefixIconColor: Colors.black,
                    hintText: "FullName",
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black)),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      isInValid = true;
                      return "This field is required";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Text("Password"),
                    prefixIconColor: Colors.black,
                    hintText: "Password",
                  ),
                ),
              ),
              TextButton(
                  style: ElevatedButton.styleFrom(onPrimary: Colors.green),
                  onPressed: () {
                    if (formState.currentState!.validate()) {
                      Provider.of<e_commerceProvider>(context,listen: false).login(controller!.text, phoneController!.text,passwordController!.text,""
                      , "",context);
                    } else {
                      debugPrint("invalid");
                    }
                  },
                  child: smallText(text: "Login", color: Colors.black)),
              Center(
                child: smallText(
                  text: "or",
                  weight: FontWeight.w700,
                ),
              ),
              SignInButton(Buttons.FacebookNew, onPressed: () {
                // loginController!.loginWithFacebook();
              }),
              SignInButton(Buttons.Google, onPressed: () {
                loginController!.googleSignIn(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
