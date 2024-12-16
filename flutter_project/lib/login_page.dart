import 'package:chat_app_2/services/Auth_Service.dart';
import 'package:chat_app_2/utils/spaces.dart';
import 'package:chat_app_2/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();

  Future <void> loginUser(BuildContext context)async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(userNameController.text);
      print(passwordController.text);
      await context.read<AuthService>().logInUser(userNameController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: '${userNameController.text}');
      print('login successful!');
    } else {
      print('not successful!');
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _mainUrl = 'https://dinosaurgame.app/';



  Widget _buildHeader(context){
    return Column(
      children: [Text(
        'Let\'s sign you in!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5),
      ),
        Text(
          'Welcome back! \n You\'ve been missed!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.blueGrey),
        ),

        verticalSpacing(24),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/illustration.png')),
              borderRadius: BorderRadius.circular(24)),
        ),],
    );

  }

  Widget _buildFooter(){
    return GestureDetector(
      onTap: () async{
        if (!await launchUrlString(_mainUrl)) {
          throw Exception('Could not launch url');
        }
        print('Link clicked!');
      },
      child: Column(
        children: [
          Text('Find us on'),
          Text(_mainUrl),
        ],
      ),
    );
  }

  Widget _buildForm(context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              LoginTextField(
                hintText: "Enter your username",
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      value.length < 5) {
                    return "Your username should be more than 5 characters";
                  } else if (value != null && value.isEmpty) {
                    return "Please type your username";
                  }
                  return null;
                },
                controller: userNameController,
              ),
              verticalSpacing(24),
              LoginTextField(
                hasAsterisks: true,
                controller: passwordController,
                hintText: 'Enter your password',
              ),
            ],
          ),
        ),
        verticalSpacing(24),
        ElevatedButton(
            onPressed: ()async {
              await loginUser(context);
            },
            child: Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            )),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context,BoxConstraints constraints) {
              if(constraints.maxWidth>constraints.maxHeight){
                return Row(
                  children: [
                    Spacer(flex: 1,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeader(context),
                          _buildFooter(),
                        ],
                      ),
                    ),
                    Spacer(flex: 1,),
                    Expanded(
                        child: _buildForm(context)),
                    Spacer(flex: 1,),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  _buildForm(context),
                  _buildFooter(),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}