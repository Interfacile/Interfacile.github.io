import 'package:dotspot_common/models/document.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class DocumentView extends StatelessWidget {
  final Document document;
  const DocumentView({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/document_details', parameters: {
        'documentId': document.id,
      }),
      child: Container(
        decoration: BoxDecoration(
          color: InterfacileTheme.secondaryOrange,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(left: 7),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: InterfacileTheme.darkBG,
            borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                 padding: const EdgeInsets.only(right: 8.0),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: Container(
                    color: InterfacileTheme.white,
                    child: Image.asset(
                      "assets/images/no_image_icon.png",
                      width: 85,
                      height: 85,
                      fit: BoxFit.none,
                    ),
                   ),
                 ),
               ),
              SizedBox(
                width: 190,
                height: 85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            document.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: InterfacileTheme.title3.copyWith(fontSize: 18),
                          ),
                        ),
                        IconButton(onPressed: () => Get.printInfo(info: "more"), icon: const Icon(Icons.more_vert, color: InterfacileTheme.white,))
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.cloud, color: document.isSync ? InterfacileTheme.primaryLightBlue : InterfacileTheme.grey,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
