import 'dart:convert';

import 'package:http/http.dart' as http;

import './secrets.dart';

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content':
                  'Does the given message wants to generate an AI picture, image, art or anything related to images? $prompt . Only and only answer Yes if you think I\'m demanding some kind of image , else No. DO NOT print anything else rather than Yes or No.',
            },
          ],
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            return res;

          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'An internal error occured!';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add(
      {'role': 'user', 'content': prompt},
    );

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add(
          {'role': 'assistant', 'content': content},
        );
        return content;
      }
      return 'An internal error occured!';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    messages.add(
      {'role': 'user', 'content': prompt},
    );

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey'
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
        }),
      );

      if (res.statusCode == 200) {
        String imageURL = jsonDecode(res.body)['data'][0]['url'];
        imageURL = imageURL.trim();
        messages.add(
          {'role': 'assistant', 'content': imageURL},
        );
        return imageURL;
      }
      return 'An internal error occured!';
    } catch (e) {
      return e.toString();
    }
  }
}