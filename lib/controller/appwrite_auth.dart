import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dotspot_common/settings.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AppWriteAuth {

  late final Client client;
  late Account account;

  AppWriteAuth() {
      client = Client()
          .setEndpoint(Settings.aWapiEndpoint)
          .setProject(Settings.aWprojectId)
          .setSelfSigned(status: true);
      account = Account(client);
  }

  Future<bool> login(String email, String password) async {
    try {
      await account.createSession(email: email, password: password);
      return true;
    } catch (e) {
      Get.printInfo(info: e.toString());
      return false;
    }
  }

  Future<bool> register(String email, String password, String username) async {
    try {
      await account.create(email: email, password: password, name: username, userId: const Uuid().v4());
      return true;
    } catch (e) {
      Get.printInfo(info: e.toString());
      return false;
    }
  }

  Future<User?> getUser() async {
    try {
      final user = await account.get();
      return user;
    } catch (e) {
      Get.printInfo(info: e.toString());
      return null;
    }
  }
}