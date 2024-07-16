import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konversiya/models/currency.dart';
import 'package:konversiya/utils/country_codes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Currency> currncys = [];

class _HomeScreenState extends State<HomeScreen> {
  // CurrencyController currencyController = CurrencyController();
  TextEditingController currencyController1 = TextEditingController();
  TextEditingController currencyController2 = TextEditingController();
  TextEditingController currencyController3 = TextEditingController();
  Currency? uz;
  Currency? country1;
  Currency? country2;

  String dropdownValue1 = "";
  String dropdownValue2 = "";
  @override
  void initState() {
    getInformation();
    super.initState();
  }

  void getInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('country1') != null) {
      country1 = currncys[prefs.getInt('country1')!];
      country2 = currncys[prefs.getInt('country2')!];
    } else {
      country1 = currncys.first;
      country2 = currncys.first;
    }

    for (var element in currncys) {
      if (element.code == 'UZS') {
        uz = element;
      }
    }

    if (prefs.getString("valyuta1") != null &&
        prefs.getString("valyuta2") != null &&
        prefs.getString("valyuta3") != null) {
      currencyController1.text = prefs.getString("valyuta1")!;
      currencyController2.text = prefs.getString("valyuta2")!;
      currencyController3.text = prefs.getString("valyuta3")!;
    } else {
      currencyController1.text = '1';
      currencyController2.text =
          (1 / uz!.value * country1!.value * 1).toStringAsFixed(3);
      currencyController3.text =
          (1 / uz!.value * country2!.value * 1).toStringAsFixed(3);
    }

    dropdownValue1 = country1!.code;
    dropdownValue2 = country2!.code;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffEAEDFC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Currency Converter",
              style: TextStyle(
                  color: const Color(0xff1F2261),
                  fontSize: 25.h,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5.h,
          ),
          Text(
              "Check live rates, set rate alerts, receive notifications and more.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.h,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(boxShadow:const [
                               BoxShadow(
                                color: Color.fromARGB(255, 206, 209, 224),
                                blurRadius: 20,
                              )
                            ], borderRadius: BorderRadius.circular(5)),
                            width: 60.w,
                            height: 30.h,
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(
                              "assets/flags/uz.png",
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("UZS",
                            style: TextStyle(
                                color: const Color(0xff1F2261),
                                fontSize: 22.h,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      width: 150.w,
                      child: TextField(
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.h),
                        onChanged: (value) async {
                          currencyController2.text = (1 /
                                  uz!.value *
                                  country1!.value *
                                  double.parse(value))
                              .toStringAsFixed(3);
                          currencyController3.text = (1 /
                                  uz!.value *
                                  country2!.value *
                                  double.parse(value))
                              .toStringAsFixed(3);
                          setState(() {});

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              "valyuta1", currencyController1.text);
                          await prefs.setString(
                              "valyuta2", currencyController2.text);
                          await prefs.setString(
                              "valyuta3", currencyController3.text);
                        },
                        onTap: () async {
                          currencyController2.text =
                              (1 / uz!.value * country1!.value * 1)
                                  .toStringAsFixed(3);
                          currencyController3.text =
                              (1 / uz!.value * country2!.value * 1)
                                  .toStringAsFixed(3);
                          currencyController1.text = '1';
                          setState(() {});
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              "valyuta1", currencyController1.text);
                          await prefs.setString(
                              "valyuta2", currencyController2.text);
                          await prefs.setString(
                              "valyuta3", currencyController3.text);
                        },
                        textAlign: TextAlign.end,
                        controller: currencyController1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7.h),
                const Divider(),
                SizedBox(height: 7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue1,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            for (var i = 0; i < currncys.length; i++) {
                              if (currncys[i].code == value) {
                                country1 = currncys[i];
                                await prefs.setInt("country1", i);
                              }
                            }

                            currencyController1.text =
                                (1 / country1!.value * uz!.value * 1)
                                    .toStringAsFixed(3);
                            currencyController3.text =
                                (1 / country1!.value * country2!.value * 1)
                                    .toStringAsFixed(3);
                            currencyController2.text = '1';
                            setState(() {
                              dropdownValue1 = value!;
                            });

                            await prefs.setString(
                                "valyuta1", currencyController1.text);
                            await prefs.setString(
                                "valyuta2", currencyController2.text);
                            await prefs.setString(
                                "valyuta3", currencyController3.text);
                          },
                          items: currncys
                              .map<DropdownMenuItem<String>>((Currency value) {
                            return DropdownMenuItem<String>(
                              value: value.code,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 206, 209, 224),
                                                blurRadius: 20,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        width: 60.w,
                                        height: 30.h,
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.asset(
                                          'assets/flags/${CountryCodes.currencyCode[value.code]?['country_code'].toString().toLowerCase()}.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Icon(Icons.error_outline);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(value.code,
                                          style: TextStyle(
                                              color: const Color(0xff1F2261),
                                              fontSize: 22.h,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 150.w,
                      child: TextField(
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.h),
                        onChanged: (value) async {
                          currencyController1.text = (1 /
                                  country1!.value *
                                  uz!.value *
                                  double.parse(value))
                              .toStringAsFixed(3);
                          currencyController3.text = (1 /
                                  country1!.value *
                                  country2!.value *
                                  double.parse(value))
                              .toStringAsFixed(3);
                          setState(() {});

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              "valyuta1", currencyController1.text);
                          await prefs.setString(
                              "valyuta2", currencyController2.text);
                          await prefs.setString(
                              "valyuta3", currencyController3.text);
                        },
                        onTap: () async {
                          currencyController1.text =
                              (1 / country1!.value * uz!.value * 1)
                                  .toStringAsFixed(3);
                          currencyController3.text =
                              (1 / country1!.value * country2!.value * 1)
                                  .toStringAsFixed(3);
                          currencyController2.text = '1';
                          setState(() {});

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              "valyuta1", currencyController1.text);
                          await prefs.setString(
                              "valyuta2", currencyController2.text);
                          await prefs.setString(
                              "valyuta3", currencyController3.text);
                        },
                        controller: currencyController2,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7.h),
                const Divider(),
                SizedBox(height: 7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue2,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            for (var i = 0; i < currncys.length; i++) {
                              if (currncys[i].code == value) {
                                country2 = currncys[i];
                                await prefs.setInt("country2", i);
                              }
                            }
                            currencyController2.text =
                                (1 / country2!.value * country1!.value * 1)
                                    .toStringAsFixed(3);
                            currencyController1.text =
                                (1 / country2!.value * uz!.value * 1)
                                    .toStringAsFixed(3);
                            currencyController3.text = '1';
                            setState(() {
                              dropdownValue2 = value!;
                            });

                            await prefs.setString(
                                "valyuta1", currencyController1.text);
                            await prefs.setString(
                                "valyuta2", currencyController2.text);
                            await prefs.setString(
                                "valyuta3", currencyController3.text);
                          },
                          items: currncys
                              .map<DropdownMenuItem<String>>((Currency value) {
                            return DropdownMenuItem<String>(
                              value: value.code,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 206, 209, 224),
                                                blurRadius: 20,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        width: 60.w,
                                        height: 30.h,
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.asset(
                                          'assets/flags/${CountryCodes.currencyCode[value.code]?['country_code'].toString().toLowerCase()}.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Icon(Icons.error_outline);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(value.code,
                                          style: TextStyle(
                                              color: const Color(0xff1F2261),
                                              fontSize: 22.h,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 150.w,
                      child: TextField(
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.h),
                        onChanged: (value) async {
                          currencyController2.text = (1 /
                                  country2!.value *
                                  country1!.value *
                                  double.parse(value))
                              .toStringAsFixed(3);
                          currencyController1.text = (1 /
                                  country2!.value *
                                  uz!.value *
                                  double.parse(value))
                              .toStringAsFixed(3);
                          setState(() {});

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              "valyuta1", currencyController1.text);
                          await prefs.setString(
                              "valyuta2", currencyController2.text);
                          await prefs.setString(
                              "valyuta3", currencyController3.text);
                        },
                        onTap: () async {
                          currencyController2.text =
                              (1 / country2!.value * country1!.value * 1)
                                  .toStringAsFixed(3);
                          currencyController1.text =
                              (1 / country2!.value * uz!.value * 1)
                                  .toStringAsFixed(3);
                          currencyController3.text = '1';
                          setState(() {});

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              "valyuta1", currencyController1.text);
                          await prefs.setString(
                              "valyuta2", currencyController2.text);
                          await prefs.setString(
                              "valyuta3", currencyController3.text);
                        },
                        textAlign: TextAlign.end,
                        controller: currencyController3,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Indicative Exchange Rate",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 15.h),
                    ),
                    SizedBox(height: 5.h),
                    if (uz != null)
                      Text(
                        "1 USD = ${uz!.value.toStringAsFixed(2)} ${uz!.code}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.h,
                            fontWeight: FontWeight.w600),
                      ),
                    SizedBox(height: 5.h),
                    if (country1 != null)
                      Text(
                        "1 USD = ${country1!.value.toStringAsFixed(2)} ${country1!.code}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.h,
                            fontWeight: FontWeight.w600),
                      ),
                    SizedBox(height: 5.h),
                    if (country2 != null)
                      Text(
                        "1 USD = ${country2!.value.toStringAsFixed(2)} ${country2!.code}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.h,
                            fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
