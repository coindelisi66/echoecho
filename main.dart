import 'package:flutter/material.dart';

void main() {
  runApp(EchoMintApp());
}

class EchoMintApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EchoMint',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MintScreen(),
    );
  }
}

class MintScreen extends StatefulWidget {
  @override
  _MintScreenState createState() => _MintScreenState();
}

class _MintScreenState extends State<MintScreen> {
  final TextEditingController _uriController = TextEditingController();
  String mintMessage = 'Henüz NFT mint edilmedi!';
  List<String> mintList = [];

  void _addMint() {
    setState(() {
      if (_uriController.text.isNotEmpty) {
        mintList.add(_uriController.text);
        mintMessage = 'NFT mint edildi: ${_uriController.text}';
        _uriController.clear();
      } else {
        mintMessage = 'Lütfen bir URI gir!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EchoMint - NFT Hikaye')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _uriController,
              decoration: InputDecoration(
                labelText: 'Hikaye URI’si gir',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMint,
              child: Text('NFT Mint Et'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(mintMessage, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: mintList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(mintList[index]),
                  subtitle: Text('NFT #${index + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}