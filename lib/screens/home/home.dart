import 'dart:convert';
import 'dart:typed_data';

import 'package:dotspot_beta_web/controller/appwrite_sync.dart';
import 'package:dotspot_beta_web/controller/preferences.dart';
import 'package:dotspot_beta_web/model/image.dart';
import 'package:dotspot_beta_web/utils/get_image.dart';
import 'package:dotspot_common/controllers/service.dart';
import 'package:dotspot_common/controllers/tags.dart';
import 'package:dotspot_common/models/document.dart';
import 'package:dotspot_beta_web/screens/too_small_screen.dart';
import 'package:dotspot_beta_web/widgets/document_view.dart';
import 'package:dotspot_beta_web/screens/home/top_bar.dart';
import 'package:dotspot_beta_web/widgets/new_document/new_document.dart';
import 'package:dotspot_beta_web/widgets/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotspot_common/widgets/dialog.dart';
import 'package:interfacile_theme/interfacile_theme.dart';
import 'package:zefyrka/zefyrka.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();
  final AppWriteSync _appWriteSync = AppWriteSync();
  List<Document> _documents = [];
  final TextEditingController _newDocTitleController = TextEditingController();
  TagsController tagsController = TagsController();
  ServicesController servicesController = ServicesController();
  bool allDocuments = true;
  final ZefyrController _synthesisController = ZefyrController();
  LocalImage? _newImage;

  @override
  void initState() {
    super.initState();
    _appWriteSync.listDocuments().then((value) {
      setState(() {
        _documents = value;
      });
    });
    _appWriteSync.syncTags();
    _appWriteSync.syncServices();
  }

  void addImage(LocalImage image) async {
    setState(() {
      _newImage = image;
    });
  }

  void createDocument() async {
    final IFPreferences prefs = IFPreferences.getInstance();
    final document = Document()
      ..title = _newDocTitleController.text
      ..description = jsonEncode(_synthesisController.document)
      ..users = ["user:${prefs.getValue<String>("userId")}"];

    if (_newImage != null) {
      document.assetPath = jsonEncode({
        "original": _newImage!.name,
        "edited": _newImage!.name,
      });
    }

    for (final tag in tagsController.tags) {
      document.tags.add(tag);
    }

    for (final service in servicesController.services) {
      document.services.add(service);
    }

    tagsController.tags.clear();
    servicesController.services.clear();

    _newDocTitleController.clear();

    await _appWriteSync.createDocument(document, image: _newImage);
    _newImage = null;
    setState(() {
      _documents.add(document);
    });
    Get.back();
    Get.toNamed('/document_details', parameters: {
      "documentId": document.id,
    });
  }

  @override
  Widget build(BuildContext context) {

    if (MediaQuery.of(context).size.width < 995) {
      return const TooSmallScreen();
    }

    return Scaffold(
      backgroundColor: InterfacileTheme.black,
      body: Row(
        children: [
          const SideBar(activeIndex: 1,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(all: allDocuments, onTapAll: () {
                setState(() {
                  allDocuments = true;
                });
              }, onTapNotAll: () {
                setState(() {
                  allDocuments = false;
                });
              },),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                            onPressed: () {
                              tagsController.tags.clear();
                              servicesController.services.clear();
                              _newDocTitleController.clear();
                              _newImage = null;
                              IFDialog.widget(
                                title: "Nouveau document",
                                height: MediaQuery.of(context).size.height * 0.9,
                                width: MediaQuery.of(context).size.height * 0.9,
                                content: NewDocument(
                                  titleController: _newDocTitleController,
                                  tagsController: tagsController,
                                  servicesController: servicesController,
                                  richTextController: _synthesisController,
                                  currentImage: _newImage,
                                  addImage: addImage,
                                ),
                                onConfirm: createDocument,
                            );
                            },
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                                  child: Icon(Icons.add, color: InterfacileTheme.black,),
                                ),
                                Text(
                                  "Nouveau",
                                  textAlign: TextAlign.center,
                                  style: InterfacileTheme.subtitle2.copyWith(
                                    color: InterfacileTheme.black,
                                  ),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              primary: InterfacileTheme.secondaryLightOrange,
                            )
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 670,
                        height: MediaQuery.of(context).size.height - 114,
                        child: ListView(
                          children:[
                            Wrap(
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                for (final document in _documents)
                                  if (document.title.toLowerCase().contains(_searchController.text.toLowerCase()))
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DocumentView(document: document,),
                                    )
                              ],
                            ),
                          ]
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 370,
                    height: MediaQuery.of(context).size.height - 50,
                    color: InterfacileTheme.darkBG,
                  )
                ],
              )
            ],
          )
        ],
      )
    );
  }
}