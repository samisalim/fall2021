import 'dart:collection';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'BottomNavugation.dart';
import 'darkTheme.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, HighlightedWord> _highlights = {
      'flutter': HighlightedWord(
        onTap: () => print('flutter'),
        textStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      'voice': HighlightedWord(
        onTap: () => print('voice'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
      'subscribe': HighlightedWord(
        onTap: () => print('subscribe'),
        textStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      'like': HighlightedWord(
        onTap: () => print('like'),
        textStyle: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      'comment': HighlightedWord(
        onTap: () => print('comment'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    };

    return Scaffold(
      backgroundColor: Color(0xFFDDD7D7),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 100),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: Container(
            width: 200.0,
            height: 200.0,
            child: new RawMaterialButton(
              shape: new CircleBorder(),
              elevation: 0.0,
              child: Column(children: [
                Icon(Icons.mic, color: Colors.red, size: 125),
                Text('Press to Record',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ))
              ]),
              onPressed: _Listen,
            ),
          )),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          width: 400,
          margin: const EdgeInsets.only(left: 5, top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights as LinkedHashMap<String, HighlightedWord>,
            textStyle: const TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _Listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final maxLines = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text('Memory Magic',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        backgroundColor: Color(0xFF3250E7),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(

                  onPressed: null,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 35,
                  ))
            ],
          )
        ],
      ),
      body: SpeechScreen(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
