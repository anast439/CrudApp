import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_to_do_list/auth/auth_page.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';
import 'package:flutter_to_do_list/screen/add_note_screen.dart';
import 'package:flutter_to_do_list/widgets/stream_note.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;
final auth=FirebaseAuth.instance;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: custom_green,
        centerTitle: true,
        title: Text('Trip Planning App'),
        actions: [IconButton(onPressed: (){
           AuthenticationRemote()
              .logout();
       Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Auth_Page(),
            ));
        }, icon: Icon(Icons.logout))],
      ),
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_creen(),
            ));
          },
          backgroundColor: custom_green,
          child: Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stream_note(false),
                // Text( 

                // auth.currentUser!.uid,
                //   style: TextStyle(
                //       fontSize: 16,
                //       color: Colors.grey.shade500,
                //       fontWeight: FontWeight.bold),
                // ),
              
              
                Stream_note(true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
