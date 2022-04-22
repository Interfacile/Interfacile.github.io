import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:dart_appwrite/dart_appwrite.dart' as server;
import 'package:dotspot_common/controllers/boxes.dart';
import 'package:dotspot_common/models/document.dart';
import 'package:dotspot_common/models/service.dart';
import 'package:dotspot_common/models/step.dart';
import 'package:dotspot_common/settings.dart';
import 'package:dotspot_common/models/tag.dart';
import 'package:dotspot_common/utils/form_database_json.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppWriteDatabase {
  late final appwrite.Client client;
  late final appwrite.Database database;
  late final server.Client serverClient;
  late final server.Database serverDatabase;

  AppWriteDatabase() {
    client = appwrite.Client()
        .setEndpoint(Settings.aWapiEndpoint)
        .setProject(Settings.aWprojectId)
        .setSelfSigned(status: true);
    database = appwrite.Database(client);
    serverClient = server.Client()
        .setEndpoint(Settings.aWapiEndpoint)
        .setProject(Settings.aWprojectId)
        .setKey(Settings.aWAPIKey)
        .setSelfSigned(status: true);
    serverDatabase = server.Database(serverClient);
  }

  Future<List<Document>> listDocuments() async {
    List<Document> documents = [];
    bool continueFetching = true;

    while (continueFetching) {
      final response = await database.listDocuments(
        collectionId: Settings.aWdocumentCollectionId,
        limit: 100,
        offset: documents.length,
      ).then((response) {
        return response.documents.map((doc) {
          List<String> users = [];
          for (var user in doc.data["\$read"]) {
            users.add(user.toString());
          }
          return Document()
          ..id = doc.data['id'] ?? ""
          ..createdTime = DateTime.fromMillisecondsSinceEpoch(doc.data['createdTime'])
          ..editedTime = DateTime.fromMillisecondsSinceEpoch(doc.data['editedTime'])
          ..title = doc.data['title'] ?? ""
          ..assetPath = doc.data['assetPath'] ?? ""
          ..steps = HiveList(Hive.box<Step>('steps'), objects: [])
          ..description = doc.data['description'] ?? ""
          ..users = users;
          // TODO: add tags and services
        });
      });
      documents.addAll(response);
      continueFetching = response.length == 100;
    }
    return documents;
  }

  Future<Document?> getDocument(String documentId) async {
    try {
      return database.getDocument(collectionId: Settings.aWdocumentCollectionId, documentId: documentId).then((appWriteDocument) async {
        List<String> users = [];
        for (var user in appWriteDocument.data["\$read"]) {
          users.add(user.toString());
        }
        Document document = Document()
        ..id = appWriteDocument.data['id'] ?? ""
        ..createdTime = DateTime.fromMillisecondsSinceEpoch(appWriteDocument.data['createdTime'])
        ..editedTime = DateTime.fromMillisecondsSinceEpoch(appWriteDocument.data['editedTime'])
        ..title = appWriteDocument.data['title'] ?? ""
        ..assetPath = appWriteDocument.data['assetPath'] ?? ""
        ..steps = HiveList(Hive.box<Step>('steps'), objects: [])
        ..description = appWriteDocument.data['description'] ?? ""
        ..users = users;
        for (String s in appWriteDocument.data["steps"]) {
          if (Boxes.findStepById(s) != null) {
            Boxes.deleteStep(Boxes.findStepById(s)!);
          }
          final tmpStep = await getStep(s);
          if (tmpStep != null) {
            Boxes.addStepWithoutDocument(tmpStep);
            document.steps.add(tmpStep);
          }
        }
        return document;
      });
    } catch (e) {
      Get.printInfo(info: e.toString());
      return null;
    }
  }

  Future<Step?> getStep(String stepId) async {
    // TODO : implement getStep
    return null;
  }

  Future<void> createDocument(Document document) async {
    try {
      await serverDatabase.createDocument(collectionId: Settings.aWdocumentCollectionId, documentId: document.id, data: documentToJsonMap(document)["document"], read: document.users, write: document.users);
    } catch (e) {
      Get.printInfo(info: e.toString());
    }
  }

  Future<List<Tag>> getTags() async {
    final List<Tag> tags = [];
    bool continueFetching = true;
    while (continueFetching) {
      final tmp = await database.listDocuments(collectionId: Settings.aWtagCollectionId, offset: tags.length).then((tags) {
        return tags.documents.map((tag) {
          Tag current = Tag(
            name: tag.data['name'] ?? "",
            color: tag.data['color'] ?? 0,
          );
          return current;
        }).toList();
      });
      tags.addAll(tmp);
      continueFetching = tmp.isNotEmpty;
    }
    return tags;
  }

  Future<List<Service>> getServices() async {
    final List<Service> services = [];
    bool continueFetching = true;
    while (continueFetching) {
      final tmp = await database
          .listDocuments(
          collectionId: Settings.aWserviceCollectionId,
          offset: services.length)
          .then((services) {
        return services.documents.map((service) {
          Service current = Service(
            name: service.data['name'] ?? "",
            color: service.data['color'] ?? 0,
          );
          return current;
        }).toList();
      });
      services.addAll(tmp);
      continueFetching = tmp.isNotEmpty;
    }
    return services;
  }
}