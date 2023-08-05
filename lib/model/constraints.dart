import 'package:e_commerce/model/oneSignalConfig.dart';
import 'package:e_commerce/model/productsModel.dart';
import 'package:e_commerce/pages//message.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class deviceUtils {
  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

class constraunts {
  static Color primary = Colors.orange;
  static Color second = Color.fromARGB(255, 104, 171, 202);
  static Color indigo = Colors.indigo;
  static Color marron = Colors.teal;
  static Color green = Colors.green;
  static double lat=0;
  static double long=0;
  Future<void> initOneSignal(BuildContext context) async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(null);
    });

    await OneSignal.shared.setAppId(oneSignalConmfig.appId);

    await OneSignal.shared
        .getDeviceState()
        .then((value) => {debugPrint("device id " + value!.userId.toString())});
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult openedResult) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => myMessagePage()));
    });
  }
 Future<List> getLocationData(double lat,double long)async{
    List<Placemark> locationData =await placemarkFromCoordinates(lat,long);
    debugPrint(locationData.toString());
    return locationData;
}
}