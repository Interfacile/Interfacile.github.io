import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

class ImagePicker extends StatelessWidget {
  final Uint8List? currentImage;
  final Function addImage;
  const ImagePicker({Key? key, required this.addImage, required this.currentImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: InterfacileTheme.black,
        border: Border.all(
          color: InterfacileTheme.secondaryLightOrange,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            child: currentImage == null ? Center(
              child: Text(
                "Ajoutez une image",
                style: InterfacileTheme.bodyText2
              ),
            ) : Image.memory(currentImage!),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => addImage(),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: InterfacileTheme.white,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.image,
                  size: 20,
                  color: InterfacileTheme.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
