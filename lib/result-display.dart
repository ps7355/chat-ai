import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'charrsponses.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _currentIndex = 0;

  Future<void> _displayChatPart(int index) async {
    if (index >= parts.length) {
      return;
    }
    final part = parts[index];
    if (part['text'] != null) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    setState(() {
      _currentIndex = index;
    });
    await Future.delayed(Duration(milliseconds: 1500));
    await _displayChatPart(index + 1);
  }

  @override
  void initState() {
    super.initState();
    _displayChatPart(0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _currentIndex >= parts.length
            ? Center(child: Text("End of chat."))
            : Column(
                children: [
                  if (parts[_currentIndex]['text'] != null)
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      key: ValueKey(parts[_currentIndex]['text']),
                      animatedTexts: [
                        TyperAnimatedText(
                          parts[_currentIndex]['text'],
                          textAlign: TextAlign.start,
                          textStyle: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.black, height: 1.4),
                          speed: const Duration(milliseconds: 10),
                        )
                      ],
                    ),
                  if (parts[_currentIndex]['code'] != null)
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CodeField(
                        controller:
                            CodeController(text: parts[_currentIndex]['code']),
                        horizontalScroll: true,
                        readOnly: true,
                        lineNumbers: true,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
