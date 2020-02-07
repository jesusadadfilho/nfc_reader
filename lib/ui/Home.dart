import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:nfc_app/tabs/Tab1.dart';
import 'package:nfc_app/tabs/Tab2.dart';
import 'package:nfc_app/tabs/Tab3.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  TabController _tabController;
  FlutterTts flutterTts = new FlutterTts();
  String _tagValue = 'Sem valor';


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_listener);
    //readNfcValue();
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _listener(){
    setState(() {
      if(_tabController.index == 0){
        Toast.show("Tutorial", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        flutterTts.speak("Toque para começar o tutorial");
      }
      else if(_tabController.index == 1){
        Toast.show("Tela principal", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        flutterTts.speak("tela principal");
      }
      else if(_tabController.index == 2){
        Toast.show("Tela do jogo", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        flutterTts.speak("Aproxime a carta da tela");
      }
    });



  }

  readNfcValue() async {
      try {
      FlutterNfcReader.read().then((response) {
        print(response.content.toString().substring(7));
        flutterTts.speak(response.content.toString().substring(7));
        Toast.show("Deu bom", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      });
    } on PlatformException {
      _tagValue = 'Failed to read NFC tag';
      flutterTts.speak('Failed to read NFC tag');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: SafeArea(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(icon: Icon(Icons.settings)),
                    Tab(icon: Icon(Icons.home)),
                    Tab(icon: Icon(Icons.videogame_asset)),
                  ],
            ),
            ),
            backgroundColor: Colors.black,
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              FirstScreen(),
              SecondScreen(),
              ThirdScreen(),
            ],
          ),
        ),
      ),
    );
  }
}




