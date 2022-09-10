import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/cubit/states.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../climat-class-model/response-model.dart';
import '../climat-class-model/serachcity_model.dart';
import '../packages/geo-locator.dart';
import '../network/http-response.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialBoardState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  Future<Weather>? response;
  Future<List<SearchCity>>? Searchresponse;
  TextEditingController cityTextController = TextEditingController();
   String? FavoriteLocationCity;
  String? FavoriteLocationIcon;
  double? FavoriteLocationTemp;
  List<String> otherLocations=[];
  dynamic position;

  void AddToOtherLocations(String city){
   otherLocations.add(city);
   emit(AddToOtherLocationsState());
  }


  void InitialLocation(){
   response=  getLocationWeather();
   emit(GetLocationState());

 }

 void ManageGetSearchChosedLocations(){
   response = getWeather(cityTextController.text);
   emit(SearchCityLocationState());
 }

  void ManageSearchLocations(){
   Searchresponse = getSearchWeather(cityTextController.text);
   emit(GetSearchLocationState());
  }

  void ChangeCityController(String name){
   cityTextController=TextEditingController(text: name);
   emit(ChangeCityControllerState());

  }

  Future<Weather> getWeather(String city) async {
  // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  final queryParameters = {
  'key': 'b581a4489ac94de5b8b142809220709',
  'q': city,
  'days'  : '7',
  'aqi' : 'no',
  'alerts' : 'no'
  };

  final uri = Uri.https(
  'api.weatherapi.com', '/v1/forecast.json', queryParameters);

  final response = await http.get(uri);

  print(response.body);
  final json = jsonDecode(response.body);
  return Weather.fromJson(json);
  }

  Future<List<SearchCity>> getSearchWeather(String SearchWord) async {
   // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

   final queryParameters = {
    'key': 'b581a4489ac94de5b8b142809220709',
    'q': SearchWord,

   };

   final uri = Uri.https(
       'api.weatherapi.com', '/v1/search.json', queryParameters);

   final response = await http.get(uri);
   List<SearchCity> searchcity;
   print(response.body);
   //final json = jsonDecode(response.body);
   searchcity=(json.decode(response.body) as List).map((i) =>
       SearchCity.fromJson(i)).toList();

   return searchcity;
  }


  Future<Weather> getLocationWeather() async {
  // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
  dynamic pos;
  pos = await determinePosition();
  print('here $pos');
  final queryParameters = {
  'key': 'b581a4489ac94de5b8b142809220709',
  'q': '${pos}',
  'days'  : '7',
  'aqi' : 'no',
  'alerts' : 'no'
  };

  final uri = Uri.https(
  'api.weatherapi.com', '/v1/forecast.json', queryParameters);

  final response = await http.get(uri);

  print(response.body);
  final json = jsonDecode(response.body);
  FavoriteLocationCity = await json['location']['name'];
  FavoriteLocationIcon = await json['current']['condition']['icon'];
  FavoriteLocationTemp = await json['current']['feelslike_c'];

  print(FavoriteLocationCity);
  print(FavoriteLocationIcon);
  print(FavoriteLocationTemp);


  return Weather.fromJson(json);
  }




}