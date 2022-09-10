import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/manage-locations-screen/presentation/pages/search_screen.dart';
import 'package:weather_app/core/utils/widgets/sidedrawer.dart';
import '../../../../core/utils/cubit/cubit.dart';
import '../../../../core/utils/cubit/states.dart';
import '../widgets/BuildFutureBuilder.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
         listener: (context, state) {},
         builder: (context, state) {
           AppCubit cubit = AppCubit.get(context);
           return Scaffold(
               extendBodyBehindAppBar: true,
               //resizeToAvoidBottomInset: false,
               appBar: AppBar(
                 backgroundColor: Colors.transparent,
                 elevation: 0.0,
                 // actions: [
                 //   IconButton(
                 //       onPressed: (){
                 //         Navigator.push(context,
                 //             MaterialPageRoute(builder: (context) =>SearchScreen() ));
                 //       },
                 //       icon: const Icon(Icons.search)),
                 //
                 // ],
               ),
               drawer: SideDrawer(),
               body: Container(
                 height: double.infinity,
                 decoration: const BoxDecoration(
                     image: DecorationImage(
                         image: AssetImage('images/black sky.jpg'),
                         fit: BoxFit.cover
                     )
                 ),
                 child: SafeArea(
                   child: SingleChildScrollView(
                     physics: BouncingScrollPhysics(),
                     child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Center(
                             child: (cubit.response==null)? Text('Search for City',style: TextStyle(color: Colors.white),) : buildfuturebuilder(cubit.response),
                           )
                         ]),
                   ),
                 ),
               ));
         }
     );

   }


}
