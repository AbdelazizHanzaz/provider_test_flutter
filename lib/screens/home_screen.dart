import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/provider/settings.dart';
import 'package:provider_app/screens/settings_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key, this.title }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    final _username  = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, SettingScreen.routeName);
            },
            icon: const Icon(Icons.settings))
        ],
        title: Text(title!)
      ),
      body: Column(
        children: [
          TextFormField(
              controller: _username,
              decoration: const InputDecoration(
                hintText: "Username",
                errorText: "Please Enter your username",
              ),
          ),
          const SizedBox(height: 16,),
          ElevatedButton(
            onPressed: ()=> Provider.of<SettingsNotifier>(context, listen: false).setUserName(_username.text), 
            child: const Text("Save Username"))
        ],
      ),
      
    );
  }
}