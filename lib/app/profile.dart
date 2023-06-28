import 'package:flutter/material.dart';
import 'package:stonks_android/app/login.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';
import '../../presentation/resources/values_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // String token = "";
  // String fname = "";
  // String sname = "";
  // String email = "";
  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    // if (token == null) {
    //   setState(() {
    //     getCred();
    //   });
    // } else {
    //   setState(() {
    //     getCred();
    //   });
    // }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // token = pref.getString("login")!;
      // fname = pref.getString("firstname")!;
      // sname = pref.getString("lastname")!;
      // email = pref.getString("email")!;
    });
  }

  var colors = ColorManager.white;
  bool click = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.black,
        title: Text(
          "Profile",
          style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeightManager.bold,
              color: ColorManager.white,
              fontSize: FontSize.s20),
        ),
      ),
      backgroundColor: ColorManager.black,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: AppSize.s13,
                  bottom: AppSize.s10,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(13),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //         color: ColorManager.grey,
              //         borderRadius:
              //             BorderRadius.all(Radius.circular(AppSize.s30))),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(
              //               left: AppSize.s18, top: AppSize.s15),
              //           child: Text(
              //             "Signed in as...",
              //             style: TextStyle(
              //                 fontFamily: FontConstants.fontFamily,
              //                 fontWeight: FontWeightManager.medium,
              //                 color: ColorManager.grey,
              //                 fontSize: FontSize.s16),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(
              //               top: AppPadding.p8, left: AppSize.s18, bottom: 20),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               Container(
              //                 height: 50,
              //                 width: 50,
              //                 decoration: BoxDecoration(
              //                     color: ColorManager.white,
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(
              //                       100,
              //                     ))),
              //                 child: Icon(
              //                   Icons.person,
              //                   color: ColorManager.black,
              //                   size: AppSize.s30,
              //                 ),
              //               ),
              //               // Padding(
              //               //   padding: const EdgeInsets.all(10.0),
              //               //   child: fname.isEmpty
              //               //       ? Text(
              //               //           "...",
              //               //           style: TextStyle(
              //               //               fontSize: FontSize.s16,
              //               //               color: ColorManager.white),
              //               //         )
              //               //       : Column(
              //               //           mainAxisAlignment:
              //               //               MainAxisAlignment.start,
              //               //           crossAxisAlignment:
              //               //               CrossAxisAlignment.start,
              //               //           children: [],
              //               //         ),
              //               // ),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: ColorManager.grey,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppSize.s30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSize.s18, top: AppSize.s15),
                        child: Text(
                          "Options",
                          style: TextStyle(
                              fontFamily: FontConstants.fontFamily,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManager.grey,
                              fontSize: FontSize.s16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppSize.s15,
                            left: AppSize.s18,
                            bottom: AppSize.s5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    fontFamily: FontConstants.fontFamily,
                                    fontWeight: FontWeightManager.medium,
                                    fontSize: FontSize.s16,
                                    color: ColorManager.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: AppSize.s15,
                              left: AppSize.s18,
                              bottom: AppPadding.p5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Terms of Service",
                                style: TextStyle(
                                    fontFamily: FontConstants.fontFamily,
                                    fontWeight: FontWeightManager.medium,
                                    fontSize: FontSize.s16,
                                    color: ColorManager.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        customBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(AppSize.s30),
                              bottomRight: Radius.circular(AppSize.s30)),
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Section currently not available..."),
                            ),
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: ((context) => Help()),
                          //     ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: AppSize.s15, left: AppSize.s18, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  "Help",
                                  style: TextStyle(
                                      fontFamily: FontConstants.fontFamily,
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: FontSize.s16,
                                      color: ColorManager.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorManager.grey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppSize.s18, top: AppSize.s15),
                        child: Text(
                          "Additional Options",
                          style: TextStyle(
                              fontFamily: FontConstants.fontFamily,
                              fontWeight: FontWeightManager.medium,
                              color: ColorManager.grey,
                              fontSize: FontSize.s16),
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: AppPadding.p10,
                            left: AppSize.s18,
                            bottom: AppSize.s10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  "About",
                                  style: TextStyle(
                                      fontFamily: FontConstants.fontFamily,
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: FontSize.s16,
                                      color: ColorManager.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        customBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(AppSize.s30),
                              bottomRight: Radius.circular(AppSize.s30)),
                        ),
                        onTap: () async {
                          shared() async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            await pref.clear();
                          }

                          AlertDialog alert = AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 40, 39, 39),
                            title: Text(
                              "Log out?",
                              style: TextStyle(color: ColorManager.white),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s30),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.white),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: AppPadding.p30),
                                child: TextButton(
                                  onPressed: () {
                                    shared();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => const Login()),
                                        ));
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.white),
                                  ),
                                ),
                              )
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: ((context) {
                              return alert;
                            }),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: AppSize.s15, left: AppSize.s18, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  "Log out",
                                  style: TextStyle(
                                      fontFamily: FontConstants.fontFamily,
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: FontSize.s16,
                                      color: ColorManager.white),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
