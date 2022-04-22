import 'package:dotspot_beta_web/controller/preferences.dart';
import 'package:get/get.dart';

void checkIfLoggedIn() {
  final IFPreferences prefs = IFPreferences.getInstance();
  if (prefs.getValue<String>("isLoggedIn") == false.toString()) {
    Future.delayed(const Duration(milliseconds: 10), () => Get.toNamed('/login'));
  }
}