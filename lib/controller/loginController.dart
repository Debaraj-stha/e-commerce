import 'dart:convert';


import 'package:e_commerce/provider/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
class login {
  googleSignIn(BuildContext context) async {
    try {
      GoogleSignIn instance = GoogleSignIn();

      final signinResult = await instance.signIn();
      // ignore: use_build_context_synchronously
      storeToDatabase(signinResult!.displayName??"", context,email: signinResult.email,photo:signinResult.photoUrl??"");
      debugPrint(signinResult.toString());
    } catch (e) {
      debugPrint(e.toString());
      throw new Exception("exception occur");
    }
  }
loginWithFacebook()async{
final LoginResult result=await FacebookAuth.instance.login();
debugPrint(result.toString());
// if(result.status=="success"){

//   }
}

storeToDatabase(String name,BuildContext context,{String email="",String photo="",String phone="",String password=""})async{
  final provider=Provider.of<e_commerceProvider>(context,listen: false);
final responee=await http.post(Uri.parse("http://10.0.2.2:8000/login"),body:{
"name":name,
"email":email,
"password":password,
"phone":phone,
"image":photo
});
final data=jsonDecode(responee.body);
if(responee.statusCode==200){
provider.showAlertMessage(context, "Login Successfull", Colors.green,false);
}
else{
  provider.showAlertMessage(context, "Login Unsuccessful.\nError:${data['message']}", Colors.green,false);
}
}
}
