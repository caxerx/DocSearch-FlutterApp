import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class ClinicAppointmentDetails extends StatelessWidget {
  var uuid = new Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "http://demo.solwininfotech.com/wordpress/veriyas-pro/wp-content/uploads/2016/05/John-Doe.jpg"),
            ),
            title: Text("Dr. Chan Tai Man"),
            subtitle: Text("Dentist"),
          ),
          Divider(
            height: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 5),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.black45,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33),
                    child: Text(
                      "Date and Time",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 72, right: 15),
                child: Text(
                  "Jan 28, 2019 (Mon) 11:00 PM",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 72, top: 5, bottom: 5),
                child: GestureDetector(
                  child: InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                child: Column(
                                  children: <Widget>[
                                    AppBar(
                                      title: Text("Select Check-in Type"),
                                      actions: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                      automaticallyImplyLeading: false,
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: <Widget>[
                                          ListTile(
                                            title: Text("Self Check-in"),
                                            subtitle: Text(
                                                "Check-in at clinic Kiosk"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      NfcDialog());
                                            },
                                          ),
                                          ListTile(
                                            title: Text("Counter Check-in"),
                                            subtitle: Text(
                                                "Check-in at clinic counter"),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              showQrDialog(context);
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Check-in",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              )
            ],
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text("Consultation Type"),
            subtitle: Text("Clinic Consultation"),
          ),
          Divider(
            height: 1,
          ),
          GestureDetector(
            child: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 5),
                        child: Icon(
                          Icons.home,
                          color: Colors.black45,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 33),
                        child: Text(
                          "Location",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 72, right: 15),
                    child: Text(
                      "Tak Po Clinic",
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 72, right: 15, top: 5),
                    child: Text(
                      "9/F, Hing Wai Building, 36 Queen's Road Central (MTR Exit D2), Central",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 10, top: 10, left: 72, right: 15),
                    child: Image.network(
                      "https://maps.googleapis.com/maps/api/staticmap?markers=small|red|9/F,%20Hing%20Wai%20Building,%2036%20Queen%27s%20Road%20Central%20(MTR%20Exit%20D2),%20Central&center=9/F,%20Hing%20Wai%20Building,%2036%20Queen%27s%20Road%20Central%20(MTR%20Exit%20D2),%20Central&zoom=13&size=700x150&maptype=roadmap%20&key=AIzaSyCkKfWny99Hef150nPJULVQx4MUXwDbe7w&scale=2",
                      fit: BoxFit.cover,
                      width: 400,
                      height: 150,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.accessibility),
            title: Text("Patient Name"),
            subtitle: Text("Chan Siu Man"),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text("Appointment ID"),
            subtitle: Text("446858414"),
          ),
        ],
      ),
    );
  }

  void showQrDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Card(
              child: Container(
                padding: EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Spacer(),
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: GestureDetector(
                                child: Icon(Icons.close),
                                onTap: () => Navigator.pop(context)),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    Text("Please show this code to counter staff"),
                    QrImage(size: 200, data: uuid.v4())
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class NfcDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NfcDialogState();
  }
}

class NfcDialogState extends State<NfcDialog> {
  NfcData _nfcData = NfcData();
  String _nfcText = "Check-in failed, please retry.";

  Future<void> startNFC(context) async {
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
    if (_nfcData.id == "0xd34556e2") {
      setState(() {
        _nfcText = "Check-in success.";
      });
      Navigator.pop(context);
    }
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

  void retry() {
    startNFC(context);
  }

  @override
  void initState() {
    startNFC(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        child: CircularProgressIndicator(),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            _nfcData.status == NFCStatus.reading
                                ? "Please place your phone near the kiosk reader."
                                : _nfcText,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("Retry"),
                      onPressed:
                          _nfcData.status == NFCStatus.reading ? null : retry,
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
