
import 'package:flutter/foundation.dart';
import 'package:provider_app/config/shared_pref/preference_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkNotifier with ChangeNotifier {

   PrefState _prefState = PrefState(true);

   DarkNotifier(){
    _loadSharedPrefs();
   }
  
  Future<void> _loadSharedPrefs() async{
    await SharedPreferences.getInstance().then((value) {
      bool darkPref = value.getBool('isDark') ?? false;

      _prefState = PrefState(darkPref);
     
    });
    notifyListeners();
  }

    Future<void> saveDarkPrefs() async{
    await SharedPreferences.getInstance().then((prefs) {
       prefs.setBool('isDark', _prefState.myDarkMode); 
    });
    notifyListeners();
  }


  bool get isDark => _prefState.myDarkMode;
}