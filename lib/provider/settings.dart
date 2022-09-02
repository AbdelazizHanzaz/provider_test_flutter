

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier  extends ChangeNotifier{
     
     SettingsNotifier(){
      getUserName();
     }

    String user = "";

    String? _username;

    String? get username => _username;
    
    Future<void> getUserName() async{

       _username = await SharedPreferences.getInstance().then<String>((sp){
        return  sp.getString("username") ?? "empty";
       
      });
      
      notifyListeners();
    }

    Future<void> setUserName(String username) async{
        await SharedPreferences.getInstance().then((sp){
             sp.setString("username", username);
        });

        notifyListeners();
    }

    set setUse(String username) => _username = username;
   
    
    


}