import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../classes/message_class.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final SpeechToText _speechToText = SpeechToText();
  String _wordsSpoken = '';

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() {
        isListening = false;
      });
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  void _startListening() async {
    await _speechToText.listen(onResult: doSomethingWithSpeechToText);
    setState(() {
      isListening = true;
    });
    print('Started listening');
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      isListening = false;
      isLoading = true;
    });
    callGeminiModule2(_wordsSpoken);
    chatController.clear();
    print('Stopped listening');
  }

  void doSomethingWithSpeechToText(result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
    });
    chatController.text = _wordsSpoken;
    print('Words Spoken: $_wordsSpoken');
  }

  final TextEditingController chatController = TextEditingController();

  bool isListening = false;

  final List<Message> _messages = [];
  final List _alreadyMessages = [
    ['Tell me some fun story about the Heart'],
    ['What are some bad effects of smoking'],
  ];

  bool isLoading = false;

  void toggleEnabling() {
    if (isListening) {
      setState(() {
        _stopListening();
      });
    } else {
      setState(() {
        _startListening();
      });
    }
  }

  callGeminiModel() async {
    if (chatController.text.isEmpty) {
      return;
    }
    try {
      if (chatController.text.isNotEmpty) {
        _messages.add(
          Message(text: chatController.text, isUser: true),
        );
        setState(() {
          isLoading = true;
        });
      }
      final model = GenerativeModel(
          model: 'gemini-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final prompt = chatController.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _messages.add(Message(text: response.text!, isUser: false));
        isLoading = false;
      });
      chatController.clear();
    } catch (e) {
      print('Error:$e');
    }
  }

  callGeminiModule2(String messageText) async {
    setState(() {
      _messages.add(Message(text: messageText, isUser: true));
      isLoading = true;
    });

    try {
      final model = GenerativeModel(
          model: 'gemini-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
      final content = [Content.text(messageText)];
      final response = await model.generateContent(content);

      setState(() {
        _messages.add(Message(text: response.text!, isUser: false));
        isLoading = false;
      });
    } catch (e) {
      print('Error:$e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Get.isDarkMode ? Colors.grey.shade700 : const Color(0xffF6F6F6),
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'H.O.B.I',
                  style: TextStyle(
                    fontFamily: 'roboto',
                    color: Get.isDarkMode
                        ? Colors.grey.shade300
                        : const Color(0xff1067F5).withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            isListening
                ? InkWell(
              onTap: toggleEnabling,
              radius: 25,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.grey.shade300
                        : const Color(0xff1067F5).withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'lib/images/micoff.png',
                    width: 30,
                    height: 30,
                    color: const Color(0xff1067F5),
                  )),
            )
                : InkWell(
              onTap: toggleEnabling,
              radius: 25,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:  Get.isDarkMode
                      ? Colors.grey.shade500
                      : const Color(0xff1067F5).withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'lib/images/mic.png',
                  width: 30,
                  height: 30,
                  color: const Color(0xff1067F5),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: _messages.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/geminni.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          callGeminiModule2(_alreadyMessages[0][0]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey.shade400)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 24,
                            ),
                            child: SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                _alreadyMessages[0][0],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          callGeminiModule2(_alreadyMessages[1][0]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey.shade400)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 24,
                            ),
                            child: SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                _alreadyMessages[1][0],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
                : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message.isUser
                            ? const Color(0xff1067F5)
                            : Colors.grey.shade300,
                        borderRadius: message.isUser
                            ? const BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                            : const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 6,
                      controller: chatController,
                      decoration:  InputDecoration(
                        hintText: 'Write your message here',
                        hintStyle: TextStyle(
                          color: Get.isDarkMode?Colors.white:Colors.grey.shade700,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ),
                  isLoading
                      ? const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 8.0),
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator()),
                  )
                      : GestureDetector(
                    onTap: callGeminiModel,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Image.asset(
                        'lib/images/send.png',
                        width: 30,
                        height: 30,
                        color: const Color(0xff1067F5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}