import 'package:dotspot_beta_web/controller/preferences.dart';
import 'package:dotspot_common/models/block.dart';
import 'package:dotspot_common/models/block_type.dart';
import 'package:dotspot_common/models/hardware.dart';
import 'package:dotspot_common/models/service.dart';
import 'package:dotspot_common/models/step.dart';
import 'package:dotspot_common/models/tag.dart';
import 'package:dotspot_beta_web/screens/dashboard.dart';
import 'package:dotspot_beta_web/screens/document_details/document_details.dart';
import 'package:dotspot_beta_web/screens/home/home.dart';
import 'package:dotspot_beta_web/screens/login.dart';
import 'package:dotspot_beta_web/screens/notifications.dart';
import 'package:dotspot_beta_web/screens/register.dart';
import 'package:dotspot_beta_web/screens/settings/settings.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interfacile_theme/interfacile_theme.dart';

import 'package:dotspot_common/models/document.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(DocumentAdapter());
  Hive.registerAdapter(BlockAdapter());
  Hive.registerAdapter(StepAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(ServiceAdapter());
  Hive.registerAdapter(BlockTypeAdapter());
  Hive.registerAdapter(HardwareAdapter());
  Hive.registerAdapter(HardwareTypeAdapter());

  await Hive.openBox('preferences');
  await Hive.openBox<Tag>('available_tags');
  await Hive.openBox<String>('deleted_tags');
  await Hive.openBox<Service>('services');
  await Hive.openBox<String>('deleted_services');
  await Hive.openBox<Hardware>('available_hardware');
  await Hive.openBox<Block>('blocks');
  await Hive.openBox<Step>('steps');
  await Hive.openBox<Document>('documents');
  await Hive.openBox<String>('deleted_documents');
  await Hive.openBox<int>('color_palette');

  final List<int> colors = Hive.box<int>('color_palette').values.toList();
  if (!colors.contains(Colors.red.value)) {
    Hive.box<int>('color_palette').add(Colors.red.value);
  }
  if (!colors.contains(Colors.green.value)) {
    Hive.box<int>('color_palette').add(Colors.green.value);
  }
  if (!colors.contains(Colors.blue.value)) {
    Hive.box<int>('color_palette').add(Colors.blue.value);
  }
  if (!colors.contains(Colors.yellow.value)) {
    Hive.box<int>('color_palette').add(Colors.yellow.value);
  }
  if (!colors.contains(Colors.orange.value)) {
    Hive.box<int>('color_palette').add(Colors.orange.value);
  }
  if (!colors.contains(Colors.purple.value)) {
    Hive.box<int>('color_palette').add(Colors.purple.value);
  }
  if (!colors.contains(Colors.pink.value)) {
    Hive.box<int>('color_palette').add(Colors.pink.value);
  }
  if (!colors.contains(Colors.cyan.value)) {
    Hive.box<int>('color_palette').add(Colors.cyan.value);
  }
  if (!colors.contains(Colors.brown.value)) {
    Hive.box<int>('color_palette').add(Colors.brown.value);
  }
  if (!colors.contains(Colors.grey.value)) {
    Hive.box<int>('color_palette').add(Colors.grey.value);
  }
  if (!colors.contains(Colors.black.value)) {
    Hive.box<int>('color_palette').add(Colors.black.value);
  }
  if (!colors.contains(Colors.white.value)) {
    Hive.box<int>('color_palette').add(Colors.white.value);
  }

  final IFPreferences prefs = IFPreferences.getInstance();
  if (prefs.getValue<String>("isLoggedIn", defaultValue: "") == "") {
    prefs.setValue<String>("isLoggedIn", false.toString());
  }
  if (prefs.getValue<String>("userId", defaultValue: "") == "") {
    prefs.setValue<String>("userId", "");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: InterfacileTheme.darkBG,
      title: 'Dotspot Beta',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => const HomePage(), transitionDuration: Duration.zero),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: '/settings', page: () => const Settings(), transitionDuration: Duration.zero),
        GetPage(name: '/document_details', page: () => const DocumentDetails(), transitionDuration: Duration.zero),
        GetPage(name: '/dashboard', page: () => const Dashboard(), transitionDuration: Duration.zero),
        GetPage(name: '/notifications', page: () => const Notifications(), transitionDuration: Duration.zero),
      ],
    );
  }
}