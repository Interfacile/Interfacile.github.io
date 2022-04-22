import 'package:appwrite/models.dart';
import 'package:dotspot_beta_web/controller/appwrite_auth.dart';
import 'package:dotspot_beta_web/controller/preferences.dart';
import 'package:dotspot_beta_web/screens/too_small_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotspot_common/widgets/button.dart';
import 'package:interfacile_theme/interfacile_theme.dart';
import 'package:dotspot_common/widgets/text_input.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  bool isLoading = false;
  bool passwordError = false;

  void _register() async {
    setState(() {
      isLoading = true;
    });
    if (_passwordController.text != _passwordConfirmController.text) {
      Get.printInfo(info: 'Passwords do not match');
      setState(() {
        isLoading = false;
        passwordError = true;
      });
      return;
    }
    setState(() {
      passwordError = false;
    });
    final AppWriteAuth auth = AppWriteAuth();
    final IFPreferences prefs = IFPreferences.getInstance();
    if (await auth.register(_emailController.text, _passwordController.text, _usernameController.text)) {
      if (await auth.login(_emailController.text, _passwordController.text)) {
        prefs.setValue<String>("isLoggedIn", true.toString());
        final User? user = await auth.getUser();
        if (user != null) {
          prefs.setValue<String>("userId", user.$id);
        }
        Get.toNamed("/");
      }
    }
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
                  hintText: "Entrez votre nom d'utilisateur",
                  labelText: "Nom d'utilisateur",
                  controller: _usernameController,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.newUsername],
                  color: InterfacileTheme.secondaryLightOrange,
                ),
              ),
            ),
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
                  color: InterfacileTheme.secondaryLightOrange,
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
                  autofillHints: const [AutofillHints.newPassword],
                  obscureText: true,
                  color: InterfacileTheme.secondaryLightOrange,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: IFInputText(
                  hintText: "Confirmez votre mot de passe ...",
                  labelText: "Confirmatin de mot de passe",
                  controller: _passwordConfirmController,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.newPassword],
                  obscureText: true,
                  color: InterfacileTheme.secondaryLightOrange,
                ),
              ),
            ),
            if (passwordError)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Text(
                  "Les mots de passe ne correspondent pas",
                  style: InterfacileTheme.bodyText1.copyWith(color: Colors.red),
                ),
              ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: IFSimpleButton(
                  text: "S'enregistrer",
                  color: InterfacileTheme.secondaryLightOrange,
                  onPressed: _register,
                  height: 60,
                  width: 200,
                )
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
                    color: InterfacileTheme.secondaryLightOrange,
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
                    color: InterfacileTheme.secondaryLightOrange,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                onTap: () => Get.toNamed("/login"),
                child: Text(
                  "Déjà un compte ? Connectez-vous",
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
