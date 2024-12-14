import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double width = size.width;
    final double height = size.height;

    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: Row(children: [
        // first half of the login screen DECORATION
        SizedBox(height: height, width: width * 0.5, child: Container(color: Colors.blue,),),
        // second half of the login screen USER DETAILS
        SizedBox(
          height: height,
          width: width * 0.5,
          child: Column(
            children: [
              Text("Login"),
              const Text("username"),
              TextFormField(controller: username,),
              const Text("password"),
              TextFormField(controller: password,),
              ElevatedButton(onPressed: () {
                print(username.text);
                print(password.text);
                },
                  child: Text("confirm"))
            ],
        ),)
      ],),
    );
  }
}
