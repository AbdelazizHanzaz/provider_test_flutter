

class Country{
 
   String name;
   String code;
   List<String> cities;
   
   Country({required this.name, required this.code, required this.cities});

   factory Country.fromJson(Map<String, dynamic> json){

    List<String> citiesList =  List.from(json["cities"].map((e) => e as String));
    return Country(
        name: json["name"],
        code: json["isoCode"],
        cities: citiesList,
    );
   }

   Map<String, dynamic> toJson() => {
         "name" : name,
         "isoCode" : code,
         "cities" : cities
   };
 

   

  
   
}


class City{
    String name;
    City({required this.name});

    City.fromJson(Map<String, dynamic> jsonCities) : name = jsonCities["name"];
}