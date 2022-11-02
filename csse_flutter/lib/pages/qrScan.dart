import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import'qruser.dart';

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({Key key}) : super(key: key);

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {

 final _formKey = GlobalKey<FormState>();
  Future save() async {
    //get methd by get the user details uning id
        var res =await http.post(Uri.parse("http://localhost:8087/qr",

    ),
        body: <String, String>{
          'id': user.id,
          'start':user. start,
          'end': user.end,
        });
       
    print(res.body);
    
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyCustomWidget()));
  }
  User user = User('', '','');
  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 16, 16),
        title: Text('QR Scanner') ,foregroundColor: Color.fromARGB(255, 246, 246, 246),

      ),
      
      body: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              Container(
                height: 230,
                width: 390,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/QR.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  String qrCode = await FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", "Cancel", true, ScanMode.QR);
                  setState(() {
                    getResult = qrCode;
                  });
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                  
                ),
                child: const Text(
                  "Scan QR",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                textColor: Colors.white,

                height: 70,
                minWidth: 140,
                color: Colors.red,
               

              ),
              SizedBox(height: 20.0,),
              Text(getResult),

              Container(
                child: Form(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                                 controller: TextEditingController(text: user.id),
                                 onChanged: (value) {
                                  user.id = value;
                                 },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                              
                            },
                                decoration: InputDecoration(
                                filled: true,
                                 fillColor: Color(0xfff46262),
                                 labelText: 'Start point',
                               labelStyle: (
                                   TextStyle(
                                     color: Colors.white,
                                     fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                )
                           ), 
                                ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                            controller: TextEditingController(text: user.start),
                            onChanged: (value) {
                              user.start = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                 fillColor: Color(0xfff46262),
                                 labelText: 'Start point',
                               labelStyle: (
                                   TextStyle(
                                     color: Colors.white,
                                     fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                )
                           ), 
                                ),
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextFormField(
                            controller: TextEditingController(text: user.end),
                            onChanged: (value) {
                              user.end = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                 fillColor: Color(0xfff46262),
                                 labelText: 'Start point',
                               labelStyle: (
                                   TextStyle(
                                     color: Colors.white,
                                     fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                )
                           ), 
                                ),
                          ),
                        ),
                              

                      
                       
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          textColor: Colors.white,

                          height: 70,
                          minWidth: 140,
                          color: Colors.red,
                          onPressed: () {
                            scanQRCode();
                          },

                        ),
                      ],
                    )
                ),
              )
            ],
          )
      ),
    );
  }

  void scanQRCode() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }

  }

}