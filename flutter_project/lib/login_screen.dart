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

    String mode = "Login";

    String getButtonText() {
      if (mode == "Login") {
        return "Switch to Sign Up";
      }
      return "Switch to Login";
    }

    return Scaffold(
      body: Row(
        children: [
          // first half of the login screen DECORATION
          SizedBox(
            height: height,
            width: width * 0.5,
            child: Container(

                color: Colors.blue,
                child: const Center(child: Text("Welcome!", style: TextStyle(color: Colors.white, fontSize: 30),)),
                ),
          ),
          // second half of the login screen USER DETAILS
          SizedBox(
            height: height,
            width: width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mode),
                const SizedBox(height: 40,),
                const Text("username"),
                const SizedBox(width: 10,),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: username,
                  ),
                ),
                const SizedBox(width: 20,),
                const Text("password"),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: password,
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () {
                      print(username.text);
                      print(password.text);
                    },
                    child: Text("confirm")),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (mode == "Login") {
                        mode = "Sign Up";
                      }
                      else {
                        mode = "Login";
                      }
                    });
                  },
                  child: Text(getButtonText()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
