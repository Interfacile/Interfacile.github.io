import 'dart:convert';
import 'dart:typed_data';

import 'package:dotspot_beta_web/controller/appwrite_database.dart';
import 'package:dotspot_beta_web/controller/appwrite_storage.dart';
import 'package:dotspot_beta_web/model/image.dart';
import 'package:dotspot_common/controllers/boxes.dart';
import 'package:dotspot_common/models/document.dart';
import 'package:dotspot_common/models/service.dart';
import 'package:dotspot_common/models/tag.dart';

class AppWriteSync {
  late final AppWriteDatabase _appWriteDatabase;
  late final AppWriteStorage _appWriteStorage;

  AppWriteSync() {
    _appWriteDatabase = AppWriteDatabase();
    _appWriteStorage = AppWriteStorage();
  }

  Future<List<Document>> listDocuments() async {
    final List<Document> documents = await _appWriteDatabase.listDocuments();
    return documents;
  }

  Future<Document?> getDocument(String documentId) async {
    return await _appWriteDatabase.getDocument(documentId);
  }

  Future<void> createDocument(Document document, {LocalImage? image}) async {
    await _appWriteDatabase.createDocument(document);
    if (image != null) {
      await _appWriteStorage.createImage(image: image, users: document.users);
    }
  }

  Future<void> syncTags() async {
    List<Tag> tags = await _appWriteDatabase.getTags();
    List<Tag> hiveTags = Boxes.findAllTags();
    for (final Tag tag in tags) {
      if (!hiveTags.contains(tag)) {
        Boxes.createTag(tag);
      }
    }
    for (final Tag tag in hiveTags) {
      if (!tags.contains(tag)) {
        Boxes.deleteTagFromHive(tag);
      }
    }
  }

  Future<void> syncServices() async {
    List<Service> services = await _appWriteDatabase.getServices();
    List<Service> hiveServices = Boxes.findAllServices();
    for (final Service service in services) {
      if (!hiveServices.contains(service)) {
        Boxes.createService(service);
      }
    }
    for (final Service service in hiveServices) {
      if (!services.contains(service)) {
        Boxes.deleteServiceFromHive(service);
      }
    }
  }
}