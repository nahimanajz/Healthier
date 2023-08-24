import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/user.model.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/repositories/user.repository.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/data/usertypes.dart';
import 'package:healthier2/utils/preferences.dart';
import 'package:healthier2/utils/toast.dart';
import 'package:healthier2/widgets/back.to.home.button.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_textFormField.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              buildSignButton(title: "Signin", () async {
                //TODO: uncomment everything below

                try {
                  var user = await UserRepository.signIn(
                      email: _emailController.text,
                      password: _passwordController.text);
                  saveSignedInUser(user as UserModel);
                  if (user?.userType == "patient") {
                    // check address then navigate to patient address or
                    return await PatientRepository.isPatientExist(
                            user.email as String)
                        ? Navigator.pushNamed(context, "/patient/dashboard")
                        : Navigator.pushNamed(context, "/patientInfo");
                  } else if (user?.userType == "clinician") {
                    Navigator.pushNamed(context, "/dashboard");
                  } else {
                    /*  //   // navigate to clinician dashboard
                  // }
                  // print(user);

                  await Navigator.pushNamed(context, "/signin",
                      arguments: {"user": user});
                      */
                  }
                } catch (e) {
                  print(e.toString());
                  showErrorToast(context, msg: e.toString());
                }
              }),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                  child: const Text("Are you new here? create account"))
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
          ],
        ),
      ),
    );
  }
}
