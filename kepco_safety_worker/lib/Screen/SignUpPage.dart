import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/models.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String Tab = "1";
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _allChecked = false;
  bool dupleChk = false;

  bool show1 = false;
  bool show2 = false;
  bool same = true;

  String id = "";
  String pwd = "";
  String pwdChk = "";
  String nm = "";
  String company = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      "회원가입",
                      textScaleFactor: FontSize.h6,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            width: MediaQuery.of(context).size.width * 0.05,
                            height: MediaQuery.of(context).size.height * 0.025,
                            decoration: BoxDecoration(
                                color: Tab == "1"
                                    ? ColorSelect.blueColor
                                    : ColorSelect.lightGreyColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "1",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.05,
                            height: MediaQuery.of(context).size.height * 0.025,
                            decoration: BoxDecoration(
                                color: Tab == "2"
                                    ? ColorSelect.blueColor
                                    : ColorSelect.lightGreyColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "2",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 30)),
              Container(
                child: Expanded(
                    child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Tab == "1"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "아이디",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(75, 76, 78, 1)),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorSelect.lightGreyColor),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[0-9]'))
                                            ],
                                            initialValue: id,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                            textInputAction:
                                                TextInputAction.next,
                                            cursorColor: ColorSelect.blueColor,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 13, left: 10),
                                              fillColor:
                                                  ColorSelect.lightGreyColor,
                                              filled: true,
                                              border: InputBorder.none,
                                              hintText: '생년월일을 아이디로 입력해 주세요',
                                              hintStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      170, 170, 170, 1)),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color:
                                                        ColorSelect.blueColor,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                id = value;
                                                show1 = false;
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 15)),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              dupleChk = !dupleChk;
                                            });
                                          },
                                          child: Text(
                                            "중복확인",
                                            style: TextStyle(
                                              color: ColorSelect.blueColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 8, bottom: 5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  child: dupleChk
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "사용가능한 아이디입니다.",
                                            textScaleFactor: FontSize.h8,
                                            style: TextStyle(
                                              color: ColorSelect.blueColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "예시 : 19800101",
                                            textScaleFactor: FontSize.h8,
                                            style: TextStyle(
                                                color: ColorSelect.greyolor),
                                          ),
                                        ),
                                ),
                                Text(
                                  "비밀번호",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(75, 76, 78, 1)),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorSelect.lightGreyColor),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                      obscureText: true,
                                      initialValue: pwd,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: ColorSelect.blueColor,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 13, left: 10),
                                        fillColor: ColorSelect.lightGreyColor,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: '핸드폰 번호를 비밀번호로 입력해 주세요',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                170, 170, 170, 1)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: ColorSelect.blueColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          pwd = value;
                                          show1 = false;
                                        });
                                      },
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "예시 : 01012345678",
                                      textScaleFactor: FontSize.h8,
                                      style: TextStyle(
                                          color: ColorSelect.greyolor),
                                    ),
                                  ),
                                ),
                                Text(
                                  "비밀번호 확인",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(75, 76, 78, 1)),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorSelect.lightGreyColor),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                      obscureText: true,
                                      initialValue: pwdChk,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: ColorSelect.blueColor,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 13, left: 10),
                                        fillColor: ColorSelect.lightGreyColor,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: '핸드폰 번호를 비밀번호로 입력해 주세요',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                170, 170, 170, 1)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: ColorSelect.blueColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          pwdChk = value;
                                          show1 = false;
                                        });
                                      },
                                    )),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                show1
                                    ? Center(
                                        child: Text(
                                          id == ""
                                              ? "아이디를 입력해주세요."
                                              : pwd == ""
                                                  ? "비밀번호를 입력해주세요."
                                                  : same
                                                      ? "비밀번호 확인을 입력해주세요."
                                                      : "비밀번호가 일치하지 않습니다. 다시 확인 후 입력해주세요.",
                                          textScaleFactor: FontSize.h7,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : Text(""),
                                const Spacer(),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorSelect.blueColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(16),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (id != "" &&
                                            pwd != "" &&
                                            pwdChk != "") {
                                          if (pwd == pwdChk) {
                                            Tab = "2";
                                          } else {
                                            same = false;
                                            show1 = true;
                                          }
                                        } else {
                                          show1 = true;
                                        }
                                      });
                                    },
                                    child: Text(
                                      "다음으로",
                                      textScaleFactor: FontSize.h7,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Center(
                                      child: Stack(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundImage: AssetImage(
                                            "assets/images/logo.png"),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 20,
                                        child: InkWell(
                                          onTap: () {
                                            print("사진촬영");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.085,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Color.fromRGBO(
                                                    217, 217, 217, 1)),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: ColorSelect.greyolor,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Center(
                                  child: Text(
                                    "프로필사진은 안전시스템 자동안면인식시 활용됩니다.",
                                    textScaleFactor: FontSize.h7,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 20)),
                                Text(
                                  "이름",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(75, 76, 78, 1)),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 20, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorSelect.lightGreyColor),
                                    child: TextFormField(
                                      initialValue: nm,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: ColorSelect.blueColor,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 13),
                                        fillColor: ColorSelect.lightGreyColor,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: '실명을 입력하세요',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          nm = value;
                                          show2 = false;
                                        });
                                      },
                                    )),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Text(
                                  "회사명",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(75, 76, 78, 1)),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 20, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorSelect.lightGreyColor),
                                    child: TextFormField(
                                      initialValue: company,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: ColorSelect.blueColor,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 13),
                                        fillColor: ColorSelect.lightGreyColor,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: '회사명을 입력하세요',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          company = value;
                                          show2 = false;
                                        });
                                      },
                                    )),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Text(
                                  "휴대폰 번호",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(75, 76, 78, 1)),
                                ),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    padding: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 20, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorSelect.lightGreyColor),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                      initialValue: phone,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: ColorSelect.blueColor,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 13),
                                        fillColor: ColorSelect.lightGreyColor,
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: '-없이 숫자만 입력해 주세요',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          phone = value;
                                          show2 = false;
                                        });
                                      },
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        activeColor: ColorSelect.blueColor,
                                        value: _allChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            _allChecked = value!;
                                            _isChecked1 = value!;
                                            _isChecked2 = value!;
                                          });
                                        }),
                                    Text(
                                      "전체 약관에 동의합니다.",
                                      textScaleFactor: FontSize.h7,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        activeColor: ColorSelect.blueColor,
                                        value: _isChecked1,
                                        onChanged: (value) {
                                          setState(() {
                                            _isChecked1 = value!;
                                          });
                                        }),
                                    Text(
                                      "(필수) ",
                                      textScaleFactor: FontSize.h7,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                      "서비스 이용약관 동의",
                                      textScaleFactor: FontSize.h7,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        activeColor: ColorSelect.blueColor,
                                        value: _isChecked2,
                                        onChanged: (value) {
                                          setState(() {
                                            _isChecked2 = value!;
                                          });
                                        }),
                                    Text(
                                      "(필수) ",
                                      textScaleFactor: FontSize.h7,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                      "개인정보 취급 정책 동의",
                                      textScaleFactor: FontSize.h7,
                                    )
                                  ],
                                ),
                                show2
                                    ? Center(
                                        child: Text(
                                          nm == ""
                                              ? "실명을 입력해주세요."
                                              : company == ""
                                                  ? "회사명을 입력해주세요."
                                                  : phone == ""
                                                      ? "휴대폰 번호를 입력해주세요."
                                                      : "약관에 동의해주세요.",
                                          textScaleFactor: FontSize.h7,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : Text(""),
                                const Spacer(),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorSelect.blueColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(16),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (nm != "" &&
                                            company != "" &&
                                            phone != "" &&
                                            _isChecked1 &&
                                            _isChecked2) {
                                          Navigator.pop(context);
                                        } else {
                                          show2 = true;
                                        }
                                      });
                                    },
                                    child: Text(
                                      "가입하기",
                                      textScaleFactor: FontSize.h7,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
