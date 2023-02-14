import 'package:flutter/material.dart';
import 'package:sky_scrapper_one/Model.dart';
import 'package:sky_scrapper_one/api_helper.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: APIHelper.apiHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error : ${snapshot.error}",
                style: TextStyle(color: Colors.black),
              ),
            );
          } else if (snapshot.hasData) {
            Currency? data = snapshot.data;
            return (data != null)
                ? Center(
                    child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: Colors.blueGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Currency Convertor",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            Global.amount = int.parse(val);
                            print(Global.amount);
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Amount',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixText: "\$"),
                        ),
                        DropdownButton(
                            value: Global.dropDownVal1,
                            dropdownColor: Colors.blueGrey.shade900,
                            iconSize: 30,
                            iconEnabledColor: Colors.white,
                            items: Global.dropDown1.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                Global.dropDownVal1 = val;
                                if (Global.dropDownVal1 == "INR") {
                                  Global.converterToAmount2 =
                                      Global.amount * data.inr;
                                } else if (Global.dropDownVal1 == "USD") {
                                  Global.converterToAmount2 =
                                      Global.amount * data.usd;
                                } else if (Global.dropDownVal1 == "CAD") {
                                  Global.converterToAmount2 =
                                      Global.amount * data.cad;
                                } else if (Global.dropDownVal1 == "AUD") {
                                  Global.converterToAmount2 =
                                      Global.amount * data.aud;
                                }
                                print("CONVERT ${Global.converterToAmount2}");
                              });
                            }),
                        const Text(
                          "Convert To",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const Icon(
                          Icons.arrow_downward,
                          size: 30,
                          color: Colors.white,
                        ),
                        DropdownButton(
                            value: Global.dropDownVal2,
                            dropdownColor: Colors.blueGrey.shade900,
                            iconEnabledColor: Colors.white,
                            items: Global.dropDown2
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                Global.dropDownVal2 = val;
                                if (Global.dropDownVal2 == "USD") {
                                  Global.converterAmount1 = data.usd;
                                  print(Global.converterAmount1);
                                  Global.sign = "\$";
                                } else if (Global.dropDownVal2 == "AUD") {
                                  Global.converterAmount1 = data.aud;
                                  Global.sign = "\$";
                                } else if (Global.dropDownVal2 == "CAD") {
                                  Global.converterAmount1 = data.cad;
                                  Global.sign = "\$";
                                } else if (Global.dropDownVal2 == "INR") {
                                  Global.converterAmount1 = data.inr;
                                  Global.sign = "\$";
                                }
                              });
                              print(Global.dropDownVal2);
                              print(Global.converterToAmount2);
                            }),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Global.convertedAmount =
                                  Global.converterToAmount2 *
                                      Global.converterAmount1;
                              print(Global.convertedAmount);
                            });
                          },
                          child: Container(
                            height: 55,
                            width: 190,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "CONVERTER",
                                style: TextStyle(
                                    color: Colors.blueGrey.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${Global.dropDownVal1} Converted to ${Global.dropDownVal2} ${Global.sign} ${Global.convertedAmount}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ))
                : const Center(
                    child: Text(
                      "No Data...",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

class Global {
  static dynamic dropDownVal1 = 'USD';
  static dynamic dropDownVal2 = 'INR';
  static var dropDown1 = ['USD', 'INR', 'CAD', 'AUD'];
  static var dropDown2 = ['INR', 'USD', 'CAD', 'AUD'];
  static dynamic convertedAmount = 0;
  static dynamic amount = 0;
  static double converterAmount1 = 0;
  static double converterToAmount2 = 0;
  static String sign = "";
}
