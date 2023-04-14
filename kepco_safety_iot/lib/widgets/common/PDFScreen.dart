import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:kepco_safety_iot/models/models.dart';

class PDFScreen extends StatefulWidget {
  // final String? path;

  PDFScreen({Key? key}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 1), (timer) {
      // print('===> 1초마다');
      if (pathPDF.isEmpty) {
        setState(() {
          pathPDF;
        });
      } else {
        timer.cancel();
        setState(() {
          pathPDF;
        });
      }

      // else
      //
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pathPDF == ''
        ? AlertDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            content: SizedBox(
                height: 200, width: 50, child: CircularProgressIndicator()))
        : AlertDialog(
            elevation: 0.0,
            iconPadding: EdgeInsets.all(0.0),
            title: Text("보고서"),
            actions: [],
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    // splashRadius: 20.0,
                    icon: Icon(
                      Icons.print,
                      size: 40,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    // splashRadius: 20.0,
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 40,
                    )),
              ],
            ),
            content: SizedBox(
              height: 800,
              width: 600,
              child: Stack(
                children: <Widget>[
                  PDFView(
                    filePath: pathPDF,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: true,
                    pageSnap: true,
                    defaultPage: currentPage!,
                    fitPolicy: FitPolicy.WIDTH,
                    preventLinkNavigation:
                        false, // if set to true the link is handled in flutter
                    onRender: (_pages) {
                      setState(() {
                        pages = _pages;
                        isReady = true;
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      setState(() {
                        errorMessage = '$page: ${error.toString()}';
                      });
                      print('$page: ${error.toString()}');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onLinkHandler: (String? uri) {
                      print('goto uri: $uri');
                    },
                    onPageChanged: (int? page, int? total) {
                      print('page change: $page/$total');
                      setState(() {
                        currentPage = page;
                      });
                    },
                  ),
                  errorMessage.isEmpty
                      ? !isReady
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container()
                      : Center(
                          child: Text(errorMessage),
                        )
                ],
              ),
            ),
          );
  }
}
