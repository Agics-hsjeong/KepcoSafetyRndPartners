// ignore_for_file: file_names, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:date_format/date_format.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kepco_safety_iot/models/models.dart';

class ExterInfoArea extends StatefulWidget {
  const ExterInfoArea({
    Key? key,
  }) : super(key: key);

  @override
  State<ExterInfoArea> createState() => _ExterInfoAreaState();
}

class _ExterInfoAreaState extends State<ExterInfoArea> {
  Future<void> _getDataFromWeb() async {
    var weather = <String>[];
    // var daydate = formatDate(DateTime.now(), [HH]);
    var ampm = formatDate(DateTime.now(), [am]);

    NaverNetwork network = NaverNetwork(
        'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=오늘날씨');
    var weatherData = await network.getJsonData();

    dom.Document document = parse.parse(weatherData);

    setState(() {
      // 온도
      var temp = document.getElementsByClassName('temperature_text');
      weather = temp
          .map((element) => element.getElementsByTagName('strong')[0].text)
          .toList();
      WeatherData.currentTemp =
          weather[0].replaceAll(RegExp('[^0-9.^0-9]'), '');

      // 어제보다
      temp = document.getElementsByClassName('temperature_info');
      weather = temp
          .map((element) => element.getElementsByTagName('p')[0].text)
          .toList();
      WeatherData.summaryTemp = weather[0].split('  ')[0];
      WeatherData.weatherTemp = weather[0].split('  ')[1].replaceAll(' ', '');
      WeatherSvg().getWeatherSvg(WeatherData.weatherTemp);

      // 체감 / 습도 / 바람
      temp = document.getElementsByClassName('temperature_info');
      weather = temp
          .map((element) =>
              element.getElementsByClassName('summary_list')[0].text)
          .toList();
      WeatherData.feelTemp = weather[0].split(' ')[2];
      WeatherData.humidityTemp = weather[0].split(' ')[4];
      WeatherData.windTemp = weather[0].split(' ')[6];

      // 강수량
      // temp = document.getElementsByClassName('climate_box');
      // weather = temp
      //     .map((element) => element.getElementsByClassName('data')[0].text)
      //     .toList();

      // WeatherData.cellTemp = weather[0].replaceAll(' ', '');

      temp = document.getElementsByClassName('week_list');
      ampm == '오전'
          ? WeatherData.cellTemp = temp[0]
              .getElementsByClassName('cell_weather')[0]
              .getElementsByClassName('rainfall')[0]
              .text
          : WeatherData.cellTemp = temp[0]
              .getElementsByClassName('cell_weather')[1]
              .getElementsByClassName('rainfall')[0]
              .text;

      // print(WeatherData.cellTemp);

      // 미세먼지
      temp = document.getElementsByClassName('item_today');
      weather = temp
          .map((element) => element.getElementsByTagName('span')[0].text)
          .toList();
      WeatherData.finedustTemp = weather[0];

      // 초미세먼지
      temp = document.getElementsByClassName('item_today');
      weather = temp
          .map((element) => element.getElementsByTagName('span')[0].text)
          .toList();
      WeatherData.ultrafinedust = weather[1];
      // print(weather[1]);

      // 지역
      temp = document.getElementsByClassName('title_area');
      weather = temp
          .map((element) => element.getElementsByClassName('title')[0].text)
          .toList();
      WeatherData.locationTemp = weather[0];
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      width: width * 0.3,
      height: height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: ColorSelect.shadowColor, spreadRadius: 1, blurRadius: 6),
        ],
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: width * 0.3,
                height: height * 0.15,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img/cloud_2.gif"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WeatherSvg.weatherSvg == ''
                            ? const Text("")
                            : SvgPicture.asset(WeatherSvg.weatherSvg,
                                width: width * 0.065),
                        Text(WeatherData.weatherTemp,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 8, top: 8),
                    //   child: VerticalDivider(
                    //       color: Colors.white60, thickness: 1.0),
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          heightFactor: 1.4,
                          child: Row(
                            children: [
                              Text(WeatherData.currentTemp,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.bold)),
                              Text("℃",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Text(WeatherData.summaryTemp,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.3,
                height: height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "풍속",
                          style: TextStyle(
                              color: ColorSelect.blueColor,
                              fontSize: width * 0.01),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                WeatherData.windTemp
                                    .replaceAll(RegExp('[^0-9.^0-9]'), ''),
                                style: TextStyle(
                                    color: ColorSelect.blueColor,
                                    fontSize: width * 0.015,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              " m/s",
                              style: TextStyle(
                                  color: ColorSelect.blueColor,
                                  fontSize: width * 0.01),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: width * 0.01, top: width * 0.01),
                      child: VerticalDivider(
                          color: ColorSelect.lineColor, thickness: 0.5),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "습도",
                          style: TextStyle(
                              color: ColorSelect.blueColor,
                              fontSize: width * 0.01),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                WeatherData.humidityTemp
                                    .replaceAll(RegExp('[^0-9.^0-9]'), ''),
                                style: TextStyle(
                                    color: ColorSelect.blueColor,
                                    fontSize: width * 0.015,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              " %",
                              style: TextStyle(
                                  color: ColorSelect.blueColor,
                                  fontSize: width * 0.01),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: width * 0.01, top: width * 0.01),
                      child: VerticalDivider(
                          color: ColorSelect.lineColor, thickness: 0.3),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "강수량",
                          style: TextStyle(
                              color: ColorSelect.blueColor,
                              fontSize: width * 0.01),
                        ),
                        WeatherData.cellTemp == '-'
                            ? Text(WeatherData.cellTemp,
                                style: TextStyle(
                                    color: ColorSelect.blueColor,
                                    fontSize: width * 0.015,
                                    fontWeight: FontWeight.bold))
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      WeatherData.cellTemp.replaceAll(
                                          RegExp('[^0-9.^0-9]'), ''),
                                      style: TextStyle(
                                          color: ColorSelect.blueColor,
                                          fontSize: width * 0.015,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    " %",
                                    style: TextStyle(
                                      color: ColorSelect.blueColor,
                                      fontSize: width * 0.01,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: width * 0.01, top: width * 0.01),
                      child: VerticalDivider(
                          color: ColorSelect.lineColor, thickness: 0.3),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "미세먼지",
                          style: TextStyle(
                              color: ColorSelect.blueColor,
                              fontSize: width * 0.01),
                        ),
                        Icon(
                          Icons.emoji_emotions_rounded,
                          size: width * 0.018,
                          color: ColorSelect.greenColor,
                        )
                        // Text(WeatherData.finedustTemp,
                        //     style: TextStyle(
                        //         color: ColorSelect.blueColor,
                        //         fontSize: width * 0.015,
                        //         fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            splashRadius: 10.0,
            icon: const Icon(Icons.restart_alt_rounded),
            color: Colors.white70,
            onPressed: () {
              setState(() {
                _getDataFromWeb();
              });
            },
          ),
        ],
      ),
    );
  }
}
