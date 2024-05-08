import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';

class LogIN_Screen extends StatefulWidget {
  final VoidCallback show;
  LogIN_Screen(this.show, {super.key});

  @override
  State<LogIN_Screen> createState() => _LogIN_ScreenState();
}

class _LogIN_ScreenState extends State<LogIN_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
 final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
bool _isLoggingIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
  }
bool isValidEmail(String email) {
  // Basic email validation using a regular expression
  // This regex pattern is a simplified version, you can use a more comprehensive one
  // based on your requirements
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                image(),
                SizedBox(height: 50),
                textfield(
                
                  email, _focusNode1, 'Email', Icons.email,(value){
                  if(value!.trim().isEmpty){
                    return 'Please Enter Your Email';
                  }else if (!isValidEmail(value)) {
      return 'Please Enter a Valid Email';
    }
                  return null;
                }
              
              
                ),
                SizedBox(height: 10),
                textfield(
                  obscureText: true,
                  password, _focusNode2, 'Password', Icons.password,(value){
                    if(value!.trim().isEmpty){
                    return 'Please Enter Your Password';
                  }else if (validatePassword(value) != null) {
      return 'Password must be at least 8 characters long';
    }
                  return null;
                }),
               
                SizedBox(height: 20),
             _isLoggingIn ? Center(child: CircularProgressIndicator(color: custom_green,)):  Login_button(),
                 SizedBox(height: 15),
                account(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Sign UP',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }





  Widget Login_button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if(_globalKey.currentState!.validate()){
AuthenticationRemote().login(email.text, password.text);
          }
          
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: custom_green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'LogIn',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

 Widget textfield(
  TextEditingController _controller,
  FocusNode _focusNode,
  String typeName,
  IconData iconss,
   String? Function(String?)? validator,
   { obscureText=false}

) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        validator: validator, 
        obscureText: obscureText,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconss,
            color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: typeName,
          border: OutlineInputBorder(),
          errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red.shade200,
              width: 2.0,
            ),
          ),
        
        
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xffc5c5c5),
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: custom_green,
              width: 2.0,
            ),
          ),
        ),
      ),
    ),
  );
}


  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: backgroundColors,
          image: DecorationImage(
            image: AssetImage('images/7.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
