import 'package:chat_ai/Backend/database.dart';
import 'package:chat_ai/charrsponses.dart';
import 'package:chat_ai/result-display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

//import 'dart:js' as js;
String currentPlan = 'Free Tier';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController askController = TextEditingController();
  TextEditingController textController = TextEditingController();
  String answer = '';
  String? _textValue = '';
  bool isLoading = false;

  // String getSelectedText() {
  //   var selection = js.context.callMethod('getSelection');
  //   return selection.toString();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getClipboard();
    RawKeyboard.instance.addListener(handelKeyBoardState);
  }

  @override
  void dispose() {
    askController.dispose();
    textController.dispose();
    RawKeyboard.instance.removeListener(handelKeyBoardState);
    dispose();
    super.dispose();
  }

  void _getClipboard() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    setState(() {
      _textValue = data?.text;
      textController.text = _textValue ?? '';
    });
  }

  Future<void> handelKeyBoardState(RawKeyEvent value) async {
    if (value is RawKeyDownEvent) {
      final k = value.logicalKey;
      if (k == LogicalKeyboardKey.enter) {
        setState(() {
          parts.clear();
          isLoading = !isLoading;
        });
        var question =
            await '${askController.text}${textController.text}'.trim();
        String d = await getAnswers(question);
        setState(() {
          isLoading = !isLoading;
          answer = d;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          //ask me anything field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: askController,
              minLines: 1,
              maxLines: 1,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: Colors.red,
                    onPressed: askController.clear,
                    icon: Icon(Ionicons.close),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                  filled: false,
                  hintText: 'Ask me anything...',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.black, width: 2))),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          //paste screen field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: Colors.red,
                    onPressed: textController.clear,
                    icon: Icon(Ionicons.close),
                  ),
                  filled: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                  hintText:
                      'If you copied something paste It Here and ask question in above field',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.black, width: 2))),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(4)),
                  height: s.height - 250,
                  width: s.width,
                  child: Stack(children: [
                    // Positioned(
                    //     top: 1,
                    //     right: 43,
                    //     child: IconButton(
                    //         padding: EdgeInsets.zero,
                    //         splashRadius: 3,
                    //         onPressed: () {},
                    //         icon: Icon(Ionicons.sync_outline))),
                    // Positioned(
                    //     top: 1,
                    //     right: 4,
                    //     child: IconButton(
                    //         splashRadius: 3,
                    //         onPressed: () async {
                    //           await Clipboard.setData(
                    //               ClipboardData(text: answer));
                    //         },
                    //         icon: Icon(Ionicons.copy_outline))),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.black,
                          ))
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ChatPage(),
                          )
                    // Padding(
                    //     padding: const EdgeInsets.only(
                    //         top: 15, left: 15, right: 15),
                    //     child: SingleChildScrollView(
                    //       child: AnimatedTextKit(
                    //           isRepeatingAnimation: false,
                    //           key: ValueKey(answer),
                    //           animatedTexts: [
                    //             TyperAnimatedText(
                    //               textAlign: TextAlign.start,
                    //               answer,
                    //               textStyle: GoogleFonts.roboto(
                    //                   fontSize: 16,
                    //                   color: Colors.black,
                    //                   height: 1.4),
                    //               speed: const Duration(milliseconds: 10),
                    //             )
                    //           ]),
                    //     ),
                    //   ),
                  ]))),
          Container(
            height: 40,
            color: Colors.amber,
            child: Row(
              children: [
                PopupMenuButton(
                    onSelected: (item) async {
                      if (item == 'logout') {
                        await Supabase.instance.client.auth.signOut();
                        Navigator.of(context).pushReplacementNamed('/sign_in');
                      } else {
                        Navigator.pushNamed(context, '/account');
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Text('My Account'),
                            value: 'account',
                          ),
                          PopupMenuItem(
                            child: Text('Logout'),
                            value: 'logout',
                          )
                        ]),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    final plan = await getPlanData();
                    setState(() {
                      currentPlan = plan;
                    });
                  },
                  child: Chip(
                    label: Text(currentPlan),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: Colors.black,
          child: Icon(
            Ionicons.send,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () async {
            // setState(() {
            //   isLoading = !isLoading;
            // });
            // var question =
            //     await '${askController.text}${textController.text}'.trim();

            // //await askController.text + textController.text.toString();
            // String d = await getAnswers(question);
            // setState(() {
            //   isLoading = !isLoading;
            //   answer = d;
            // });
            //addPlanDetails();
            //Supabase.instance.client.auth.signOut();
          }),
    );
  }
}

//  Positioned(
//                         top: 1,
//                         right: 43,
//                         child: IconButton(
//                             splashRadius: 1,
//                             onPressed: () {},
//                             icon: Icon(Ionicons.sync_outline))),
//                     Positioned(
//                         top: 1,
//                         right: 4,
//                         child: IconButton(
//                             splashRadius: 1,
//                             onPressed: () async {
//                               await Clipboard.setData(
//                                   ClipboardData(text: answer));
//                             },
//                             icon: Icon(Ionicons.copy_outline)))
