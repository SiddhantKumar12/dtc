import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:new_dtc/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> list = <String>['one', 'two', 'three', 'four'];

class ConfigurePage extends StatefulWidget {
  const ConfigurePage({Key? key}) : super(key: key);

  @override
  State<ConfigurePage> createState() => _ConfigurePageState();
}

class _ConfigurePageState extends State<ConfigurePage> {
  String startingStop = list.first;
  String endingStop = list.first;
  int hexCode = 0xFFCCFF90;
  int fare = 10;

  TextEditingController busNumberController = TextEditingController();
  TextEditingController busRouteController = TextEditingController();
  TextEditingController startingStopController = TextEditingController();
  TextEditingController endingStopController = TextEditingController();

  List<bool> isFareSelected = [false, true, false, false, false];
  List<bool> isHexCodeSelected = [false, true, false, false, false];

  void localStore({String? busNumber, String? busRoute, int? fare, required int hexCode, String? startingStop, String? endingStop}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('busNumber', busNumber!);
    await prefs.setString('busRoute', busRoute!);
    await prefs.setInt('fare', fare!);
    await prefs.setInt('hexCode', hexCode);
    await prefs.setString('startingStop', startingStop!);
    await prefs.setString('endingStop', endingStop!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configure Page",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        // backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTextField(labelText: 'Bus Number', textEditingController: busNumberController),
            buildTextField(labelText: 'Bus Route', textEditingController: busRouteController),
            ToggleButtons(
              isSelected: isFareSelected,
              selectedColor: Colors.white,
              color: Colors.grey,
              fillColor: Colors.blue,
              renderBorder: true,
              // splashColor: Colors.red,
              highlightColor: Colors.blueAccent,
              borderColor: Colors.blue,
              children: const <Widget>[
                ChartFilterText(title: '5'),
                ChartFilterText(title: '10'),
                ChartFilterText(title: '15'),
                ChartFilterText(title: '20'),
                ChartFilterText(title: '25'),
              ],
              onPressed: (int newIndex) {
                setState(() {
                  for (int index = 0; index < isFareSelected.length; index++) {
                    if (index == newIndex) {
                      isFareSelected[index] = true;
                      if (newIndex == 0) {
                        fare = 5;
                      } else if (newIndex == 1) {
                        fare = 10;
                      } else if (newIndex == 2) {
                        fare = 15;
                      } else if (newIndex == 3) {
                        fare = 20;
                      } else {
                        fare = 25;
                      }
                    } else {
                      isFareSelected[index] = false;
                    }
                  }
                  setState(() {});
                });
              },
            ),
            ToggleButtons(
              isSelected: isHexCodeSelected,
              selectedColor: Colors.white,
              color: Colors.grey,
              fillColor: Color(hexCode),
              renderBorder: true,
              // splashColor: Colors.red,
              highlightColor: Color(hexCode),
              borderColor: Colors.blue,
              children: const <Widget>[
                ChartFilterText2(title: 'Red'),
                ChartFilterText2(title: 'Green'),
                ChartFilterText2(title: 'Orange'),
                ChartFilterText2(title: 'Blue'),
                ChartFilterText2(title: 'Custom'),
              ],
              onPressed: (int newIndex) {
                setState(() {
                  for (int index = 0; index < isHexCodeSelected.length; index++) {
                    if (index == newIndex) {
                      isHexCodeSelected[index] = true;
                      if (newIndex == 0) {
                        hexCode = 0xFFFF8A80;
                      } else if (newIndex == 1) {
                        hexCode = 0xFFCCFF90;
                      } else if (newIndex == 2) {
                        hexCode = 0xFFFFD180;
                      } else if (newIndex == 3) {
                        hexCode = 0xFF82B1FF;
                      } else {
                        hexCode = 0xff448AFFFF;
                      }
                    } else {
                      isHexCodeSelected[index] = false;
                    }
                  }
                });
              },
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: list
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: startingStop,
                  onChanged: (value) {
                    setState(() {
                      startingStop = value as String;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: 200,
                  itemHeight: 40,
                  dropdownMaxHeight: 200,
                  searchController: startingStopController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: startingStopController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue.toLowerCase()));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      startingStopController.clear();
                    }
                  },
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: DropdownButton<String>(
                value: endingStop,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  setState(() {
                    endingStop = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  localStore(
                    busNumber: busNumberController.text.trim(),
                    busRoute: busRouteController.text.trim(),
                    fare: fare,
                    hexCode: hexCode,
                    startingStop: startingStop,
                    endingStop: endingStop,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  TextField buildTextField({required String labelText, required TextEditingController textEditingController}) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => textEditingController.clear(),
          )),
    );
  }
}

class ChartFilterText extends StatelessWidget {
  final String title;

  const ChartFilterText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
      child: Text(title,
          style: TextStyle(
            fontSize: 18,
          )),
    );
  }
}

class ChartFilterText2 extends StatelessWidget {
  final String title;

  const ChartFilterText2({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.width * 0.12,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.0125),
        child: Center(
          child: Text(title,
              style: TextStyle(
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}
