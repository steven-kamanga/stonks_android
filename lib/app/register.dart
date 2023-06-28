import 'dart:ui';
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stonks_android/app/nav_bar.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';
import '../../presentation/resources/values_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:validators/validators.dart';
import 'landing.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var click = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> globalKey3 = GlobalKey<FormState>();

  bool hasInternet = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool showPassword = false;
  int statcode = 0;
  int taps = 0;

  @override
  void initState() {
    checkInternet();
    checkLogin();
    super.initState();
  }

  checkInternet() async {
    var internetCheck = await InternetConnectionChecker().hasConnection;
    if (internetCheck == true) {
      setState(() {
        hasInternet = true;
      });
    } else {
      setState(() {
        hasInternet = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No internet Connection Available"),
        ),
      );
      setState(() {
        hasInternet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Center(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p30),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                child: Text('Stonks Android',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeightManager.bold,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p30,
                          right: AppPadding.p30,
                          bottom: 15,
                          top: AppPadding.p10),
                      child: Form(
                        key: globalKey3,
                        child: TextFormField(
                          style: TextStyle(color: ColorManager.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field required";
                            } else if (!isEmail(value.trim())) {
                              return "Enter a valid email";
                            } else {
                              return null;
                            }
                          },
                          controller: nameController,
                          cursorColor: ColorManager.white,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.lightGray),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.white),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            label: const Text("Name"),
                            labelStyle: TextStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                            ),
                            hintStyle: TextStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                            hintText: "name name",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p30,
                          right: AppPadding.p30,
                          bottom: 15,
                          top: AppPadding.p10),
                      child: Form(
                        key: globalKey,
                        child: TextFormField(
                          style: TextStyle(color: ColorManager.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field required";
                            } else if (!isEmail(value.trim())) {
                              return "Enter a valid email";
                            } else {
                              return null;
                            }
                          },
                          controller: emailController,
                          cursorColor: ColorManager.white,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.lightGray),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.white),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            label: const Text("Email"),
                            labelStyle: TextStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                            ),
                            hintStyle: TextStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.normal,
                            ),
                            hintText: "example@gmail.com",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p30, right: AppPadding.p30),
                      child: Form(
                        key: globalKey2,
                        child: TextFormField(
                          style: TextStyle(color: ColorManager.white),
                          validator: (value) =>
                              value!.isEmpty ? "Field required" : null,
                          controller: passController,
                          cursorColor: ColorManager.white,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(
                              AppPadding.p15,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.lightGray,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.lightGray,
                              ),
                            ),
                            label: const Text("Password"),
                            labelStyle: TextStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintStyle: TextStyle(color: ColorManager.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorManager.white,
                                size: AppSize.s18,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: InkWell(
                          onTap: (() async {
                            final isValidForm =
                                globalKey.currentState?.validate();
                            final isValidForm2 =
                                globalKey2.currentState?.validate();
                            if (isValidForm == true && isValidForm2 == true) {
                              checkInternet();
                              setState(() => isLoading = true);
                              await Future.delayed(const Duration(seconds: 1));
                              login();
                            } else {
                              setState(() => isLoading = false);
                            }
                          }),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: AppPadding.p30, right: AppPadding.p30),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: isLoading == false
                                    ? Text(
                                        "Sign in",
                                        style: TextStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s16,
                                          fontWeight: FontWeightManager.bold,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      )
                                    : SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: AppSize.s3,
                                          color: ColorManager.black,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");
    if (val != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: ((context) => const NavBar()),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Credentials. Please try again"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void login() async {
    String baseUrl = "http://192.168.43.134:5000/api/v1/auth/register";
    var response = await http.post(Uri.parse(baseUrl),
        body: ({
          'name': nameController.text,
          'email': emailController.text,
          'password': passController.text,
        }),
        headers: {
          "Accept": "application/json",
        });
    // ignore: avoid_print
    print(response.statusCode.toString());
    print(response.body.toString());

    final body = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      setState(() {
        statcode = response.statusCode;
      });
      await Future.delayed(const Duration(seconds: 1));
      pageRoute(body["token"], body["name"], body["email"], body["_id"]);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Landing()));
    } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${body["message"]}"),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode >= 500 && response.statusCode <= 599) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${body["message"]}"),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }

    await Future.delayed(const Duration(seconds: 20));
    setState(() => isLoading = false);
  }

  void pageRoute(String token, String name, String email, String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
    await pref.setString("name", name);
    await pref.setString("email", email);
    await pref.setString("password", passController.text);
    await pref.setString("_id", id);
  }
}
