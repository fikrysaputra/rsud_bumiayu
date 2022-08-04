import 'package:flutter/material.dart';
import 'package:rsudbumiayu/dashboard.dart';

import 'auth.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Welcome createState() => Welcome();
}

class Welcome extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2DA6AB),
                  Color(0xFF247EAA),
                ],
              ),
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'RSUD BUMIAYU',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 194,
                      width: 259,
                      child: Center(child : Image(
                        image: AssetImage("assets/rsud.png"),
                        fit: BoxFit.fill,
                      ),),),
                      const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Container(
                          height: 50,
                          width: 240.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                            },
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Container(
                          height: 50,
                          width: 240.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                            },
                            child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Container(
                          height: 50,
                          width: 240.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              signInWithGoogle().then((result) {
                                if (result != null) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Dashboard();
                                      },
                                    ),
                                  );
                                }
                              });
                            },
                            child: const Center(
                              child: Text(
                                "Sign In with Google",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
