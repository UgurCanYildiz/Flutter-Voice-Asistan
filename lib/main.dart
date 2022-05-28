import 'package:alan_voice/alan_callback.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

final Uri _url = Uri.parse('https://www.google.com/search?q=');
final Uri _gurl = Uri.parse('https://mail.google.com');
final Uri _cvurl = Uri.parse('https://github.com/UgurCanYildiz');
final Uri _lurl =
    Uri.parse('https://www.linkedin.com/in/u%C4%9Fur-can-yildiz-3b7102233/');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
    AlanVoice.addButton(
        "4f69ce056ac603dd433520d3068bb3432e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      _handleCommand(command.data);
    });
  }

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

  void _handleCommand(Map<String, dynamic> command) {
    switch (command["command"]) {
      case "search":
        _launchUrl();
        break;
      case "mail":
        _glaunchUrl();
        break;
      default:
        debugPrint("Hata");
    }
  }
}

void _launchUrl() async {
  if (!await launchUrl(_url)) throw 'Could not launch $_url';
}

void _glaunchUrl() async {
  if (!await launchUrl(_gurl)) throw 'Could not launch $_gurl';
}

void _cvUrl() async {
  if (!await launchUrl(_cvurl)) throw 'Could not launch $_cvurl';
}

void _lUrl() async {
  if (!await launchUrl(_lurl)) throw 'Could not launch $_lurl';
}
