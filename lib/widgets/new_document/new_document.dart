import 'dart:typed_data';
import 'package:dotspot_beta_web/model/image.dart';
import 'package:dotspot_beta_web/utils/get_image.dart';
import 'package:dotspot_beta_web/widgets/new_document/image_picker.dart';
import 'package:dotspot_common/controllers/boxes.dart';
import 'package:dotspot_common/controllers/service.dart';
import 'package:dotspot_common/controllers/tags.dart';
import 'package:dotspot_common/models/service.dart';
import 'package:dotspot_common/models/tag.dart';
import 'package:dotspot_common/widgets/rich_text_input.dart';
import 'package:dotspot_common/widgets/service_drop_down.dart';
import 'package:dotspot_common/widgets/tags_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:dotspot_common/widgets/text_input.dart';
import 'package:interfacile_theme/interfacile_theme.dart';
import 'package:zefyrka/zefyrka.dart';

class NewDocument extends StatefulWidget {
  final TextEditingController titleController;
  final TagsController tagsController;
  final ServicesController servicesController;
  final ZefyrController richTextController;
  final Function addImage;
  final LocalImage? currentImage;

  const NewDocument({Key? key,
    required this.titleController,
    required this.tagsController,
    required this.servicesController,
    required this.richTextController,
    required this.currentImage,
    required this.addImage}) : super(key: key);

  @override
  State<NewDocument> createState() => _NewDocumentState();
}

class _NewDocumentState extends State<NewDocument> {

  List<Tag> _availableTags = [];
  List<Service> _availableServices = [];
  LocalImage? _currentImage;

  @override
  initState() {
    super.initState();
    _availableTags = Boxes.findAllTags();
    _availableServices = Boxes.findAllServices();
    _currentImage = widget.currentImage;
  }

  void _addImage() async {
    final image = await getImage();
    if (image != null) {
      setState(() {
        _currentImage = image;
      });
      widget.addImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: IFInputText(
            controller: widget.titleController,
            hintText: 'Entrez le titre du document',
            labelText: 'Titre du document',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TagSelector(
            updateParent: () => setState(() {}),
            availableTags: _availableTags,
            selectedTags: widget.tagsController,
          )
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ServiceSelector(
            updateParent: () => setState(() {}),
            availableServices: _availableServices,
            selectedServices: widget.servicesController,
          )
        ),
        Padding(padding: const EdgeInsets.all(16),
          child: ImagePicker(currentImage: _currentImage?.data, addImage: _addImage),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: double.infinity,
            height: 1,
            color: InterfacileTheme.secondaryLightOrange,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(child: Text("Synthèse", style: InterfacileTheme.title2))
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: IFRichTextInput(controller: widget.richTextController)
        ),
      ],
    );
  }
}

