import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NoInternet extends StatefulWidget {
  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool isConnect = true;

  Future<void> checkConnectivity() async {
    var connectivityresult = await (Connectivity().checkConnectivity());
    if (connectivityresult == ConnectivityResult.none) {
      setState(() {
        isConnect = false;
      });
    } else {
      setState(() {
        isConnect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/images/no-internet.png",
              width: 250,
            )),
            SizedBox(height: 150),
            Center(
              child: Text(
                "Lost Connection",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              child: Center(
                child: Text(
                  "Whoops... no internet connection found. Check your connection",
                  style: TextStyle(fontSize: 16),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 80),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      checkConnectivity();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Try Again",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF3F42),
                      foregroundColor: Colors.white,

                    ),
                    ),
                    
              ),
            )
          ],
        ),
      )),
    );
  }
}
