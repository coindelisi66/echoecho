import 'package:flutter/material.dart';

void main() {
  runApp(EchoEchoApp());
}

class EchoEchoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EchoEcho',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: EchoScreen(),
    );
  }
}

class EchoScreen extends StatefulWidget {
  @override
  _EchoScreenState createState() => _EchoScreenState();
}

class _EchoScreenState extends State<EchoScreen> {
  final TextEditingController _castController = TextEditingController();
  String echoMessage = 'Henüz echo yok!';
  List<String> echoChain = [];

  void _addEcho() {
    setState(() {
      if (_castController.text.isNotEmpty) {
        echoChain.add(_castController.text);
        echoMessage = 'Echo eklendi: ${_castController.text}';
        _castController.clear();
      } else {
        echoMessage = 'Lütfen bir cast URL’si gir!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EchoEcho - Hikaye Zinciri')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _castController,
              decoration: InputDecoration(
                labelText: 'Farcaster Cast URL’si',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addEcho,
              child: Text('Echo Ekle'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            ),
            SizedBox(height: 20),
            Text(echoMessage, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: echoChain.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(echoChain[index]),
                  subtitle: Text('Echo #${index + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}