import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive/rive.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LogoFade(),
    );
  }
}

class LogoFade extends StatefulWidget {
  @override
  State<LogoFade> createState() => LogoFadeState();
}

class LogoFadeState extends State<LogoFade> {
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 1),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                child: const RiveAnimation.asset('assets/rive/ani.riv'),
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _changeOpacity,
          child: const Text('클릭시 사라짐'),
        ),
      ],
    );
  }
}
