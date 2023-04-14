// ignore_for_file: file_names, unused_local_variable

import 'package:date_format/date_format.dart';

class WeatherData {
  static var currentTemp = '';
  static var weatherTemp = '';
  static var summaryTemp = '';
  static var feelTemp = '';
  static var humidityTemp = '';
  static var windTemp = '';
  static var cellTemp = '';
  static var finedustTemp = '';
  static var superFinedustTemp = '';
  static var ultravioletTemp = '';
  static var locationTemp = '';
  static var ultrafinedust = '';
}

class WeatherSvg {
  static String weatherSvg = '';

  final List<String> weatherSvgList = <String>[
    'assets/svg/icon_flat_wt1.svg',
    'assets/svg/icon_flat_wt2.svg',
    'assets/svg/icon_flat_wt3.svg',
    'assets/svg/icon_flat_wt4.svg',
    'assets/svg/icon_flat_wt5.svg',
    'assets/svg/icon_flat_wt6.svg',
    'assets/svg/icon_flat_wt7.svg',
    'assets/svg/icon_flat_wt8.svg',
    'assets/svg/icon_flat_wt9.svg',
    'assets/svg/icon_flat_wt10.svg',
    'assets/svg/icon_flat_wt11.svg',
    'assets/svg/icon_flat_wt12.svg',
    'assets/svg/icon_flat_wt13.svg',
    'assets/svg/icon_flat_wt14.svg',
    'assets/svg/icon_flat_wt15.svg',
    'assets/svg/icon_flat_wt16.svg',
    'assets/svg/icon_flat_wt17.svg',
    'assets/svg/icon_flat_wt18.svg',
    'assets/svg/icon_flat_wt19.svg',
    'assets/svg/icon_flat_wt20.svg',
    'assets/svg/icon_flat_wt21.svg',
    'assets/svg/icon_flat_wt22.svg',
    'assets/svg/icon_flat_wt23.svg',
    'assets/svg/icon_flat_wt24.svg',
    'assets/svg/icon_flat_wt25.svg',
    'assets/svg/icon_flat_wt26.svg',
    'assets/svg/icon_flat_wt27.svg',
    'assets/svg/icon_flat_wt28.svg',
    'assets/svg/icon_flat_wt29.svg',
    'assets/svg/icon_flat_wt30.svg',
    'assets/svg/icon_flat_wt31.svg',
    'assets/svg/icon_flat_wt32.svg',
    'assets/svg/icon_flat_wt33.svg',
    'assets/svg/icon_flat_wt34.svg',
    'assets/svg/icon_flat_wt35.svg',
    'assets/svg/icon_flat_wt36.svg',
    'assets/svg/icon_flat_wt37.svg',
    'assets/svg/icon_flat_wt38.svg',
    'assets/svg/icon_flat_wt39.svg',
    'assets/svg/icon_flat_wt40.svg',
    'assets/svg/icon_flat_wt41.svg',
  ];

  void getWeatherSvg(weather) async {
    var daydate = formatDate(DateTime.now(), [HH]);
    var weatherImg = 'NB01';

    if (int.parse(daydate) > 18 || int.parse(daydate) < 6) {
      switch (weather) {
        case '맑음':
          weatherSvg = weatherSvgList[1];
          break;
        case '구름조금':
          weatherSvg = weatherSvgList[3];
          break;
        case '구름많음':
          weatherSvg = weatherSvgList[5];
          break;
        case '흐림':
          weatherSvg = weatherSvgList[6];
          break;
        case '약한비':
          weatherSvg = weatherSvgList[7];
          break;
        case '비':
          weatherSvg = weatherSvgList[8];
          break;
        case '강한비':
          weatherSvg = weatherSvgList[9];
          break;
        case '약한눈':
          weatherSvg = weatherSvgList[10];
          break;
        case '눈':
          weatherSvg = weatherSvgList[11];
          break;
        case '강한눈':
          weatherSvg = weatherSvgList[12];
          break;
        case '진누깨비':
          weatherSvg = weatherSvgList[13];
          break;
        case '소나기':
          weatherSvg = weatherSvgList[14];
          break;
        case '소낙눈':
          weatherSvg = weatherSvgList[15];
          break;
        case '안개':
          weatherSvg = weatherSvgList[39];
          break;
        case '번개, 뇌우':
          weatherSvg = weatherSvgList[17];
          break;
        case '우박':
          weatherSvg = weatherSvgList[18];
          break;
        case '황사':
          weatherSvg = weatherSvgList[40];
          break;
        case '가끔 비':
          weatherSvg = weatherSvgList[30];
          break;
        case '비 또는 눈':
          weatherSvg = weatherSvgList[20];
          break;
        case '가끔 비, 눈':
          weatherSvg = weatherSvgList[32];
          break;
        case '가끔 눈':
          weatherSvg = weatherSvgList[31];
          break;
        case '흐린 후 갬':
          weatherSvg = weatherSvgList[33];
          break;
        case '뇌우 후 갬':
          weatherSvg = weatherSvgList[34];
          break;
        case '비 후 갬':
          weatherSvg = weatherSvgList[35];
          break;
        case '눈 후 갬':
          weatherSvg = weatherSvgList[36];
          break;
        case '흐려져 비':
          weatherSvg = weatherSvgList[37];
          break;
        case '흐려져 눈':
          weatherImg = weatherSvgList[38];
          break;
        default:
      }
    } else {
      switch (weather) {
        case '맑음':
          weatherSvg = weatherSvgList[0];
          break;
        case '구름조금':
          weatherSvg = weatherSvgList[2];
          break;
        case '구름많음':
          weatherSvg = weatherSvgList[4];
          break;
        case '흐림':
          weatherSvg = weatherSvgList[6];
          break;
        case '약한비':
          weatherSvg = weatherSvgList[7];
          break;
        case '비':
          weatherSvg = weatherSvgList[8];
          break;
        case '강한비':
          weatherSvg = weatherSvgList[9];
          break;
        case '약한눈':
          weatherSvg = weatherSvgList[10];
          break;
        case '눈':
          weatherSvg = weatherSvgList[11];
          break;
        case '강한눈':
          weatherSvg = weatherSvgList[12];
          break;
        case '진누깨비':
          weatherSvg = weatherSvgList[13];
          break;
        case '소나기':
          weatherSvg = weatherSvgList[14];
          break;
        case '소낙눈':
          weatherSvg = weatherSvgList[15];
          break;
        case '안개':
          weatherSvg = weatherSvgList[16];
          break;
        case '번개, 뇌우':
          weatherSvg = weatherSvgList[17];
          break;
        case '우박':
          weatherSvg = weatherSvgList[18];
          break;
        case '황사':
          weatherSvg = weatherSvgList[19];
          break;
        case '가끔 비':
          weatherSvg = weatherSvgList[21];
          break;
        case '비 또는 눈':
          weatherSvg = weatherSvgList[20];
          break;
        case '가끔 비, 눈':
          weatherSvg = weatherSvgList[23];
          break;
        case '가끔 눈':
          weatherSvg = weatherSvgList[22];
          break;
        case '흐린 후 갬':
          weatherSvg = weatherSvgList[24];
          break;
        case '뇌우 후 갬':
          weatherSvg = weatherSvgList[25];
          break;
        case '비 후 갬':
          weatherSvg = weatherSvgList[26];
          break;
        case '눈 후 갬':
          weatherSvg = weatherSvgList[27];
          break;
        case '흐려져 비':
          weatherSvg = weatherSvgList[28];
          break;
        case '흐려져 눈':
          weatherImg = weatherSvgList[29];
          break;
        default:
      }
    }
  }
}
