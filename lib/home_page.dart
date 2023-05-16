import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import './feature_box.dart';
import './pallete.dart';
import './openai_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();

  String speech = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 1000;
  int delay = 500;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> setSpeechRate() async {
    await flutterTts
        .setSpeechRate(0.5); // Adjust the value as per your preference
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      speech = result.recognizedWords;
      // print(speech);
      // print(result.toJson());
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BounceInDown(
          duration: Duration(milliseconds: start * 5),
          child: const Text(
            'Allen\'s App',
            style: TextStyle(
              fontFamily: 'Cera Pro',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.menu_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              duration: Duration(milliseconds: start * 6),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: const BoxDecoration(
                        color: Pallete.assistantCircleColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/virtualAssistant.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            FadeInRight(
              duration: Duration(milliseconds: start * 4),
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ).copyWith(
                    top: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      30,
                    ).copyWith(
                      topLeft: const Radius.circular(0),
                      bottomRight: const Radius.circular(0),
                    ),
                  ),
                  child: Text(
                    generatedContent == null
                        ? 'Hello, what can I do to help you?'
                        : generatedContent!,
                    style: TextStyle(
                      fontFamily: 'Falling Sky',
                      fontSize: generatedContent == null ? 25 : 18,
                      color: Pallete.mainFontColor,
                    ),
                  ),
                ),
              ),
            ),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(generatedImageUrl!),
                ),
              ),
            SlideInLeft(
              duration: Duration(milliseconds: start * 4),
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 25,
                    left: 20,
                  ),
                  alignment: Alignment
                      .centerLeft, // padding and margin does the same thing if there are no borders
                  child: const Text(
                    'Here are a few features you can try',
                    style: TextStyle(
                      fontFamily: 'Falling Sky',
                      fontSize: 20,
                      color: Pallete.mainFontColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: FeatureBox(
                      headerText: 'ChatGPT',
                      bodyText:
                          'Using ChatGPT, there is a better way to keep informed and organized.',
                      color: Colors.limeAccent.withOpacity(0.7),
                    ),
                  ),
                  SlideInRight(
                    delay: Duration(milliseconds: start + delay),
                    child: FeatureBox(
                      headerText: 'Dall-E',
                      bodyText:
                          'Using your personal assistant powered by Dall-E, be creative and be inspired.',
                      color: Colors.deepOrangeAccent.withOpacity(0.7),
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + delay * 2),
                    child: FeatureBox(
                      headerText: 'Smart Voice Assistant',
                      bodyText:
                          'Use a voice assistant that is powered by ChatGPT and Dall-E to get the best of both worlds.',
                      color: Colors.tealAccent.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + delay * 3),
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final output = await openAIService.isArtPromptAPI(speech);
              if (output.contains('https')) {
                generatedImageUrl = output;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = output;
                setState(() {});
                await setSpeechRate();
                await systemSpeak(output);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(
            speechToText.isListening ? Icons.stop_rounded : Icons.mic_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
