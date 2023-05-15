import 'package:flutter/material.dart';

import './feature_box.dart';
import './pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Allen\'s App',
          style: TextStyle(
            fontFamily: 'Cera Pro',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.menu_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
            Container(
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
              child: const Text(
                'Hello, what can I do to help you?',
                style: TextStyle(
                  fontFamily: 'Falling Sky',
                  fontSize: 25,
                  color: Pallete.mainFontColor,
                ),
              ),
            ),
            Container(
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
            Column(
              children: [
                FeatureBox(
                  headerText: 'ChatGPT',
                  bodyText:
                      'Using ChatGPT, there is a better way to keep informed and organized.',
                  color: Colors.limeAccent.withOpacity(0.7),
                ),
                FeatureBox(
                  headerText: 'Dall-E',
                  bodyText:
                      'Using your personal assistant powered by Dall-E, be creative and be inspired.',
                  color: Colors.deepOrangeAccent.withOpacity(0.7),
                ),
                FeatureBox(
                  headerText: 'Smart Voice Assistant',
                  bodyText:
                      'Use a voice assistant that is powered by ChatGPT and Dall-E to get the best of both worlds.',
                  color: Colors.tealAccent.withOpacity(0.7),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.mic_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
