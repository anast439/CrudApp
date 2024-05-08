import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/auth/main_page.dart';
import 'package:flutter_to_do_list/screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
  Future.delayed(Duration(seconds: 5),(){
    final auth=FirebaseAuth.instance;
    if(auth.currentUser != null){
              Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home_Screen()),
        );


    }else{
              Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Main_Page()),
        );

    }
  });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: Container(
          width: MediaQuery.sizeOf(context) .width * 0.8,
          
          child: Center(
            child:Image.asset('images/splash.gif') ,
          ),
        ),
      ),
    );
  }
}