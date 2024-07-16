import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konversiya/controllers/currency_controller.dart';
import 'package:konversiya/views/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CurrencyController controller = CurrencyController();
  @override
  void initState() {
    _init();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    });
    super.initState();
  }

  void _init() async {
    currncys = await controller.getInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff31BD9D),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200.w,
            child: Image.asset("assets/logo.png"),
          ),
          SizedBox(height: 10.h),
          Text(
            "Currency",
            style: TextStyle(
                fontSize: 33.h,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
