import 'package:dotspot_beta_web/controller/appwrite_sync.dart';
import 'package:dotspot_beta_web/screens/document_details/top_bar.dart';
import 'package:dotspot_common/models/document.dart';
import 'package:dotspot_beta_web/screens/too_small_screen.dart';
import 'package:dotspot_beta_web/widgets/side_bar/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class DocumentDetails extends StatefulWidget {
  const DocumentDetails({Key? key}) : super(key: key);

  @override
  State<DocumentDetails> createState() => _DocumentDetailsState();
}

class _DocumentDetailsState extends State<DocumentDetails> {

  Document document = Document();
  AppWriteSync appWriteSync = AppWriteSync();
  String documentId = "";

  @override
  void initState() {
    super.initState();
    try {
      documentId = Get.parameters["documentId"] ?? "";
    // ignore: empty_catches
    } catch (e) {}
    appWriteSync.getDocument(documentId).then((value) {
      if (value != null) {
        setState(() {
          document = value;
        });
      }
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
          const SideBar(activeIndex: -5),
          SizedBox(
            width: MediaQuery.of(context).size.width - 300,
            child: Column(
              children: [
                const TopBar(),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 300,
                  height: MediaQuery.of(context).size.height - 50,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 670,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                document.title,
                                style: InterfacileTheme.title2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: InterfacileTheme.darkBG,
                        width: 370,
                        height: MediaQuery.of(context).size.height - 50,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
