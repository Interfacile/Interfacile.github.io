import 'dart:typed_data';

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:dart_appwrite/dart_appwrite.dart' as server;
import 'package:dotspot_beta_web/model/image.dart';
import 'package:dotspot_common/settings.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AppWriteStorage {
  late final appwrite.Client client;
  late final appwrite.Storage storage;
  late final server.Client serverClient;
  late final server.Storage serverStorage;

  AppWriteStorage() {
    client = appwrite.Client()
        .setEndpoint(Settings.aWapiEndpoint)
        .setProject(Settings.aWprojectId)
        .setSelfSigned(status: true);
    storage = appwrite.Storage(client);
    serverClient = server.Client()
        .setEndpoint(Settings.aWapiEndpoint)
        .setProject(Settings.aWprojectId)
        .setKey(Settings.aWAPIKey)
        .setSelfSigned(status: true);
    serverStorage = server.Storage(serverClient);
  }

  Future<void> createImage({required LocalImage image, required List<String> users}) async {
    Get.printInfo(info: 'Creating file: ${image.name}');
    final server.MultipartFile multipartFile = server.MultipartFile.fromBytes("img", image.data, filename: image.name);
    Get.printInfo(info: 'file size ${multipartFile.length}');
    await serverStorage.createFile(
        bucketId: Settings.aWassetBucketId,
        fileId: const Uuid().v4(),
        read: users,
        write: users,
        file: server.InputFile(filename: image.name, file: multipartFile));
  }
}