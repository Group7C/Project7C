
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }




  static late final SharedPreferences _prefs;

  Future<void> logInUser(String userName) async{
    try {
      _prefs.setString('userName', userName);
    }catch(e){
      print(e);
    }

  }

  void logOutUser(){
    _prefs.clear();
  }

  String? getUserName(){
    return _prefs.getString('userName')?? 'default value';
  }

  void updateUserNAme(String newName){
    
  }
}