import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/data/models/country.dart';
import 'package:provider_app/provider/settings.dart';

class SettingScreen extends StatelessWidget {
  final String? title;
  const SettingScreen({Key? key, required this.title}) : super(key: key);

  static const routeName = "/settings";

  Future<List<Country>> _loadCountries() async {
    final jsonString = await rootBundle.loadString("assets/files/country.json");
    final List<dynamic> response = json.decode(jsonString);
    final List<Country> countries =
        List.from(response.map((e) => Country.fromJson(e)));
    //test data
    log(countries[0].cities.last);

    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  Provider.of<SettingsNotifier>(context, listen: false)
                      .setUserName("Edit Username"),
              icon: const Icon(Icons.refresh))
        ],
        title: Text(title!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<SettingsNotifier>(builder: (context, state, child) {
              return Text("Username is : ${state.username}");
            }),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                "Select Your Location:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
                future: _loadCountries(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Country>> snapshot) {
                  Country? _country;
                  final List<Country>? _countries = snapshot.data;
                  if (snapshot.hasData) {
                    return DropdownButton<Country>(
                
                        borderRadius: BorderRadius.circular(20),
                        hint: const Text("Select your country"),
                        elevation: 3,
                        //isExpanded: true,
                        value: _country ?? _countries![0],
                        onChanged: (Country? val) => _country = val,
                        items:
                            snapshot.data!.map<DropdownMenuItem<Country>>((val) {
                              log(val.code.toLowerCase());
                          return DropdownMenuItem<Country>(
                            value: val,
                            child: Row(
                              children: [
                                ClipRRect(
                                  child: Image.asset("assets/flag/flag_ma.png", height: 80,),
                                ),
                                Text(val.name)
                              ],
                            ),
                          );
                        }).toList());
                  } else {
                    return const Text("No Data yet!!!");
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadCountries,
        child: const Icon(Icons.download),
      ),
    );
  }
}
