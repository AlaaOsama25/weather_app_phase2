import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/cubit/cubit.dart';
import 'features/home-page-screen/presentaion/pages/home_screen.dart';
void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..InitialLocation(),
    child :MaterialApp(
      title: 'Clima',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            //color: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light
          ),
        ),

      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    )
    );
  }
}

