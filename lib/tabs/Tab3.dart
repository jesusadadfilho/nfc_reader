import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';




class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {



  FlutterTts flutterTts = new FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      Toast.show(onData.id, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Toast.show(onData.content, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      flutterTts.speak(onData.content);
    });
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.nfc,
                size: 50,
              ),
              Text("Aproxime a carta da tela")

            ],
          )
      ),
    );
  }
}