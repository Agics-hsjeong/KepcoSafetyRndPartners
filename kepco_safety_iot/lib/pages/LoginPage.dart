// ignore_for_file: avoid_print, file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Network network = Network();
  String userId = 'kepri';
  String userPw = 'rhdxhd12!@';

  void onLogin() async {
    print("onLogin");
    await network.setLogin(userId, userPw).then((value) async {
      if (value.status == 'success') {
        Status.user = value.userinfo!.toJson();
        print('===> ${Status.user}');
        requestPersmission();
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // print(value.message);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/login_bg.png"), fit: BoxFit.fill),
          ),
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Image(image: AssetImage("assets/img/logo.png")),
                    Text(
                      TextModel.title,
                      style: TextStyle(
                          color: ColorSelect.blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontFamily: 'Wemakeprice'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'ID',
                        ),
                        onChanged: (value) => setState(() {
                          userId = value;
                          // print(userId);
                        }),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          hintText: 'PW',
                        ),
                        obscureText: true,
                        onChanged: (value) => setState(() {
                          userPw = value;
                          // print(userPw);
                        }),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () => onLogin(),
                        child: const Text("로그인"),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
