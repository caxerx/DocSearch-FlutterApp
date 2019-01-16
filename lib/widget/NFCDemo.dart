import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter/services.dart';

class NFCDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NFCState();
  }
}

class NFCState extends State<NFCDemo> {
  NfcData _nfcData = NfcData();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            if (_nfcData.status == NFCStatus.reading) {
              stopNFC();
            } else {
              startNFC();
            }
          },
          child: Text(_nfcData.status == NFCStatus.reading ? "STOP" : "READ"),
        ),
        Text("${_nfcData.status}"),
        Text("${_nfcData.id}"),
        Text("${_nfcData.content}")
      ],
    );
  }

  Future<void> startNFC() async {
    NfcData response;

    setState(() {
      _nfcData = NfcData();
      _nfcData.status = NFCStatus.reading;
    });

    print('NFC: Scan started');

    try {
      print('NFC: Scan readed NFC tag');
      response = await FlutterNfcReader.read;
    } on PlatformException {
      print('NFC: Scan stopped exception');
    }
    setState(() {
      _nfcData = response;
    });
  }

  Future<void> stopNFC() async {
    NfcData response;

    try {
      print('NFC: Stop scan by user');
      response = await FlutterNfcReader.stop;
    } on PlatformException {
      print('NFC: Stop scan exception');
      response = NfcData(
        id: '',
        content: '',
        error: 'NFC scan stop exception',
        statusMapper: '',
      );
      response.status = NFCStatus.error;
    }

    setState(() {
      _nfcData = response;
    });
  }
}
