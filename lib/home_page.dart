import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? busNumber;
  String? busRoute;
  int? fare;
  int? hexCode;
  String? startingStop;
  String? endingStop;

  @override
  void initState() {
    super.initState();
    getLocalStorage();
  }

  void getLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    busNumber = prefs.getString('busNumber');
    busRoute = prefs.getString('busRoute');
    fare = prefs.getInt('fare');
    hexCode = prefs.getInt('hexCode');
    startingStop = prefs.getString('startingStop');
    endingStop = prefs.getString('endingStop');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexCode != null ? hexCode! : 0xFFCCFF90),
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        elevation: 0,
        backgroundColor: Colors.lightGreenAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                const Icon(Icons.rotate_90_degrees_ccw),
                const SizedBox(width: 5),
                const Text("All Tickets", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Image.asset("assets/caution.png", height: MediaQuery.of(context).size.width * 0.065),
                const SizedBox(width: 5),
                const Text("Report", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            FlipCard(
              flipOnTouch: true,
              fill: Fill.none,
              // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.HORIZONTAL,
              // default
              front: Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.01),
                height: MediaQuery.of(context).size.height * 0.48,
                width: double.maxFinite,
                color: Colors.lightGreenAccent,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Transport Dept. of Delhi',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              busNumber!,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Rs 9.0',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.black, thickness: 0.6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Bus Route'),
                            Text('Fare'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              busRoute!,
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              'Rs 10.0',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Booking Time'),
                            Text('Tickets'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateTime.now().toString().split(".").first,
                              style: const TextStyle(fontSize: 17),
                            ),
                            const Text('1'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Starting stop'),
                            SizedBox(height: 3),
                            Text(startingStop!),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ending stop'),
                            SizedBox(height: 3),
                            Text(endingStop!),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "T54F5VEOXI5VEOXI",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.maxFinite,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.lightGreenAccent,
                                disabledBackgroundColor: Colors.lightGreenAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                            onPressed: null,
                            icon: Icon(Icons.qr_code, size: MediaQuery.of(context).size.width * 0.08, color: Colors.white),
                            label: const Text(
                              "Show QR Code",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              back: Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.01),
                height: MediaQuery.of(context).size.height * 0.47,
                width: double.maxFinite,
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.01, vertical: MediaQuery.of(context).size.height * 0.01),
                  child: QrImage(
                    data: "1234567890",
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
            ),
            Container(
              height: 45,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.height * 0.01, bottom: 15),
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                onPressed: () {},
                child: const Text(
                  "Get Latest ticket",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
