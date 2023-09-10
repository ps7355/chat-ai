import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class codeBox extends StatelessWidget {
  const codeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: TypewriterText()

          // Center(
          //   child: LayoutBuilder(
          //     builder: (context, constraints) => Container(
          //       width: 200.0,
          //       color: Colors.black,
          //       height: constraints.maxWidth,
          //       child: AnimatedTextKit(
          //         animatedTexts: [
          //           TyperAnimatedText(
          //             'Hello, World!saDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHsaDJFHJDSFHJSHDJFHJHJHnksfdksdjfkjaksdfj',
          //             textStyle: TextStyle(fontSize: 15.0, color: Colors.white),
          //             speed: Duration(milliseconds: 10),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}

class TypewriterText extends StatefulWidget {
  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  double _containerHeight = 50.0; // initial height of the container
  String _text =
      'Hello, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrdllo, Worlawerrrrrrrrrrrd!';
  TextStyle _textStyle = TextStyle(fontSize: 20.0, fontFamily: 'Courier');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: 700,
            height: _containerHeight,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.white),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        _text,
                        textStyle: _textStyle.copyWith(color: Colors.white),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    onFinished: () {
                      // calculate the actual height of the text widget after it is fully typed
                      double textHeight = _getTextHeight(_text, _textStyle);
                      if (textHeight > _containerHeight) {
                        // if the actual height of the text is greater than the initial height of the container, expand the container
                        setState(() {
                          _containerHeight =
                              textHeight + 16.0; // add some padding
                        });
                      }
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }

  // Get the height of the text widget
  double _getTextHeight(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.height;
  }
}
