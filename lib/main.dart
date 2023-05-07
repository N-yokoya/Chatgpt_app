// TO USE CHATGPT APPLICATION HERE
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  String _responseText = '';

  Future<void> _getResponse() async {
    final url = Uri.parse('https://api.chatgpt.com/ask');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_TOKEN',
      },
      body: jsonEncode({'question': _textController.text}),
    );

    final responseJson = jsonDecode(response.body);

    setState(() {
      _responseText = responseJson['answer'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: '質問を入力してください',
            ),
          ),
          ElevatedButton(
            onPressed: _getResponse,
            child: Text('送信'),
          ),
          SizedBox(height: 16),
          Text(
            _responseText,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}