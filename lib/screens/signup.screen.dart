import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/user.model.dart';
import 'package:healthier2/repositories/user.repository.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/data/usertypes.dart';
import 'package:healthier2/utils/toast.dart';
import 'package:healthier2/widgets/back.to.home.button.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';
import '../widgets/custom_textFormField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userTypeController = TextEditingController();

  //final _residencyCityController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, color: lightColorScheme.primary),
        ),
        backgroundColor: lightColorScheme.secondary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: gradientDecoration,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                child: Center(
                  child: SvgPicture.asset('assets/images/clinic.svg'),
                ),
              ),
              buildPatientAddressForm(),
              buildSignButton(() async {
                try {
                  var user = UserModel(
                      email: _emailController.text,
                      password: _passwordController.text,
                      userType: _userTypeController.text);
                  // TODO: navigate to signin  screen
                  await UserRepository.create(user);
                  await Navigator.pushNamed(context, "/signin",
                      arguments: {"user": user});
                } catch (e) {
                  showErrorToast(context);
                }
              }),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/signin");
                  },
                  child: Text("Already signed up? signin"))
            ],
          ),
        ),
      ),
    );
  }

  Flexible buildPatientAddressForm() {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildTextFormField("Email", _emailController,
                keyboardType: TextInputType.emailAddress),
            buildTextFormField("Password", _passwordController, isHidden: true),
            buildSelectFormField(_userTypeController, userRoles,
                labelText: "Choose user",
                dialogTitle: "User type",
                searchHint: "Choose user"),
          ],
        ),
      ),
    );
  }
}
