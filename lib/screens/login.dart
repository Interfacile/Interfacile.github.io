import 'package:appwrite/models.dart';
import 'package:dotspot_beta_web/controller/appwrite_auth.dart';
import 'package:dotspot_beta_web/controller/preferences.dart';
import 'package:dotspot_beta_web/screens/too_small_screen.dart';
import 'package:dotspot_common/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotspot_common/widgets/button.dart';
import 'package:interfacile_theme/interfacile_theme.dart';
import 'package:dotspot_common/widgets/text_input.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void _login() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    final AppWriteAuth auth = AppWriteAuth();
    final IFPreferences prefs = IFPreferences.getInstance();
    if (await auth.login(_emailController.text, _passwordController.text)) {
      prefs.setValue<String>("isLoggedIn", true.toString());
      final User? user = await auth.getUser();
      if (user != null) {
        prefs.setValue<String>("userId", user.$id);
      }
      Get.toNamed("/");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 995) {
      return const TooSmallScreen();
    }
    return Scaffold(
      backgroundColor: InterfacileTheme.darkBG,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/images/Dotspot.png')),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: IFInputText(
                  hintText: "Entrez votre adresse mail ...",
                  labelText: "Adresse mail",
                  controller: _emailController,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.email],
                  color: InterfacileTheme.primaryBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: IFInputText(
                  hintText: "Entrez votre mot de passe ...",
                  labelText: "Mot de passe",
                  controller: _passwordController,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                  color: InterfacileTheme.primaryBlue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IFSimpleButton(
                text: "Se connecter",
                color: InterfacileTheme.primaryBlue,
                onPressed: _login,
                height: 60,
                width: 200,
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                onTap: () => Get.printInfo(info: 'Forgot password'),
                child: Text(
                  "Mot de passe oublié ?",
                  style: InterfacileTheme.bodyText1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 40,
                    color: InterfacileTheme.primaryLightBlue,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      "ou",
                      style: InterfacileTheme.bodyText1,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 40,
                    color: InterfacileTheme.primaryLightBlue,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                onTap: () => Get.toNamed("/register"),
                child: Text(
                  "Se créer un compte",
                  style: InterfacileTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
