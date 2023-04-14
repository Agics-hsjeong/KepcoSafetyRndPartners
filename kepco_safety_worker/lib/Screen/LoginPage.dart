import '../Constant/Constant.dart';
import 'package:flutter/material.dart';
import 'package:kepco_safety_worker/Screen/SignUpPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late AnimationController buttonController;
  late Animation<double> buttonSqueezeAnimation;
  // late Animation<double> buttonZoomout;

  void navigationPage() {
    Navigator.of(context).pushNamed(HOME_SCREEN);
  }

  Future _playAnimation() async {
    try {
      await buttonController.forward();
      await buttonController.reverse();
    } on TickerCanceled {}
  }

  bool isSaveLogin = false;
  bool isAutoLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    username.text = "";
    password.text = "";

    buttonController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        navigationPage();
      }
    });

    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: const Interval(0.0, 0.250),
    ));

    buttonSqueezeAnimation.addListener(() => setState(() {}));

    // buttonZoomout = Tween(
    //   begin: 70.0,
    //   end: 1000.0,
    // ).animate(CurvedAnimation(
    //   parent: buttonController,
    //   curve: const Interval(
    //     0.550,
    //     0.999,
    //     curve: Curves.elasticOut,
    //   ),
    // ));

    // buttonZoomout.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle: const TextStyle(fontSize: 14),
        primary: username.text != '' && password.text != ''
            ? Color.fromRGBO(69, 94, 238, 1)
            : Color.fromRGBO(238, 238, 238, 1),
        fixedSize: Size(MediaQuery.of(context).size.width - 40, 40));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "로그인",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("아이디"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 25),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  // labelText: "Username",
                  prefixIcon: Icon(Icons.people),
                  // border: myinputborder(),
                  enabledBorder: myinputborder(),
                  focusedBorder: myfocusborder(),
                ),
              ),
            ),
            Row(
              children: [
                Text("비밀번호"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: password,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  // labelText: "Username",
                  prefixIcon: Icon(Icons.lock),
                  // border: myinputborder(),
                  enabledBorder: myinputborder(),
                  focusedBorder: myfocusborder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: isSaveLogin,
                  onChanged: (value) => setState(() {
                    isSaveLogin = !isSaveLogin;
                  }),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide(color: Colors.grey),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(
                    Color.fromRGBO(69, 94, 238, 1),
                  ),
                ),
                Text(
                  "로그인 정보 저장",
                  style: TextStyle(
                      color: isSaveLogin ? Colors.black87 : Colors.grey),
                ),
                Checkbox(
                  value: isAutoLogin,
                  onChanged: (value) => setState(() {
                    isAutoLogin = !isAutoLogin;
                  }),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide(color: Colors.grey),
                  fillColor:
                      MaterialStateProperty.all(Color.fromRGBO(69, 94, 238, 1)),
                ),
                Text(
                  "자동 로그인",
                  style: TextStyle(
                      color: isAutoLogin ? Colors.black87 : Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _playAnimation();
              },
              child: Hero(
                tag: "fade",
                child: Container(
                    width: buttonSqueezeAnimation.value,
                    height: 50.0,
                    alignment: FractionalOffset.center,
                    decoration: BoxDecoration(
                      color: username.text == '' || password.text == ''
                          ? Colors.grey[300]
                          : Color.fromRGBO(69, 94, 238, 1),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: buttonSqueezeAnimation.value > 75.0
                        ? const Text(
                            "로그인",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3,
                            ),
                          )
                        : const CircularProgressIndicator(
                            value: null,
                            strokeWidth: 1.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    child: Text(
                      "비밀번호 찾기",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      "회원가입",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
