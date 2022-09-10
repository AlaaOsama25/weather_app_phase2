import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/widgets/my_separator.dart';

import '../../../features/manage-locations-screen/presentation/pages/search_screen.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return SafeArea(
            child: Drawer(
              backgroundColor: Colors.black,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(icon:Icon(Icons.settings),color: Colors.white,
                          onPressed: ()
                          {
                            //Navigator.pop(context);
                          },)
                      ],),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.star,color: Colors.white,),
                          ),
                          Text('Current Location',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          Spacer(),
                          Icon(Icons.info_outline,color: Colors.white,),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.location_on_rounded, color: Colors.white,size: 13,),
                                SizedBox(width: 5,),
                                Text('${cubit.FavoriteLocationCity!}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                Spacer(),
                                Image.network('https:${cubit.FavoriteLocationIcon!}',width: 50,height: 50,),
                                Text('${cubit.FavoriteLocationTemp!.round()!}°',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),



                              ],
                            ),
                          ),
                          MySeparator(color: Colors.grey,),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on_rounded, color: Colors.white),
                          ),
                          Text('Other Locations',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          Spacer(),

                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: 10, minWidth: double.infinity,),
                      //height: 10,
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: (cubit.otherLocations.isEmpty)? 0 : cubit.otherLocations.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 40),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_rounded, color: Colors.white,size: 13,),
                                    SizedBox(width: 5,),
                                    Text('${cubit.otherLocations[index]!}',
                                      style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              )),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>SearchScreen() ));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  height: 50,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Manage Locations',textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold,))
                                  )


                              ),
                            ),
                          ),
                          MySeparator(color: Colors.grey,),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                        Icon(Icons.info_outline,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Report Wrong Location',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w400),),

                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.headset_mic_outlined,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Contact Us',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w400),),

                        ],),
                    )





                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
