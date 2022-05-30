import 'package:alan_voice/alan_callback.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';

void main() {
  runApp(const MyApp());
}

///Fonksiyonlara gidicek olan adresler
final Uri _surl = Uri.parse('sms:5550101234');
final Uri _turl = Uri.parse('tel:+90-533-333-33-33');
final Uri _url = Uri.parse('https://www.google.com/search?q=');
final Uri _gurl = Uri.parse('https://mail.google.com');
final Uri _cvurl = Uri.parse('https://github.com/UgurCanYildiz');
final Uri _lurl =
    Uri.parse('https://www.linkedin.com/in/u%C4%9Fur-can-yildiz-3b7102233/');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Arayüz ve arka plan kısmı
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sesli Asistan',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Mobil Programlama Final'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    ///Alan studio token ile bağlanma
    AlanVoice.addButton(
        "4f69ce056ac603dd433520d3068bb3432e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Alan Studiodan command ı alma.
    AlanVoice.onCommand.add((command) {
      _handleCommand(command.data);
    });
  }

  ///Arayüz kısmı ("Tusların Oldugu yer")
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: _lUrl, child: const Text("Linkedin")),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: ElevatedButton(onPressed: _cvUrl, child: Text("Github")),
            )
          ],
        ),
      ),
    );
  }

  ///ALAN STUDİODAN GELEN Command a göre hangi fonksiyonu çağırcağını belirtir.

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "search":
        _launchUrl();
        break;
      case "call":
        _tUrl();
        break;
      case "mail":
        _glaunchUrl();
        break;

      ///(Calışmıyor)
      case "SMS":
        _sendSMS(message, recipents);
        break;
      //Programdan çıkış
      case "exit":
        SystemNavigator.pop();
        break;

      default:
        debugPrint("Hata");
    }
  }
}

//GOOGLE SEARCH FONKSİYONU
void _launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

//MAİL FONKSİYONU
void _glaunchUrl() async {
  if (!await launchUrl(_gurl)) throw 'Could not launch $_gurl';
}

//CV FONKSİYONU
void _cvUrl() async {
  if (!await launchUrl(_cvurl)) throw 'Could not launch $_cvurl';
}

//LİNKEDİN FONKSİYONU
void _lUrl() async {
  if (!await launchUrl(_lurl)) throw 'Could not launch $_lurl';
}

//ARAMA FONKSİYONU
void _tUrl() async {
  if (!await launchUrl(_turl)) throw 'Could not launch $_turl';
}

//Sms fonksiyonu(Calışmıyor)
void _sendSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {});
  print(_result);
}

//Fonksiyona giricek no ve mesaj(Calışmıyor)
String message = "This is a test message!";
List<String> recipents = ["1234567890", "5556787676"];
