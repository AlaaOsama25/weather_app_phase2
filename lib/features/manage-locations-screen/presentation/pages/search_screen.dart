import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/climat-class-model/serachcity_model.dart';
import '../../../../core/utils/cubit/cubit.dart';
import '../../../../core/utils/cubit/states.dart';
import '../../../../core/utils/network/http-response.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(State is ChangeCityControllerState ){

          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text('Search City'),
              backgroundColor: Colors.black,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.cityTextController,
                          onChanged: (value){
                            cubit.ManageSearchLocations();

                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            labelText: 'Search City',
                            labelStyle: TextStyle(
                                color: Colors.white
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),

                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            cubit.ManageGetSearchChosedLocations();
                            cubit.AddToOtherLocations(cubit.cityTextController.text);
                            cubit.cityTextController.clear();
                            cubit.Searchresponse=null;
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.search,color: Colors.white,)
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                    child: FutureBuilder<List<SearchCity>>(
                      future: cubit.Searchresponse,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        cubit.ChangeCityController(snapshot.data![index].name.toString());
                                        //cubit.AddToOtherLocations(snapshot.data![index].name.toString());
                                        print(snapshot.data?[index].name);
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('images/black sky.jpg'),
                                                fit: BoxFit.cover
                                            ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: 70,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('${snapshot.data![index].country}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
                                            ),
                                            Container(color: Colors.grey,height:60,width: 1,),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('${snapshot.data![index].name}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
                                                        Text('${snapshot.data![index].region}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ) ,


                                          ],),
                                      ),
                                    ),
                                  ),
                          );


                        }
                        else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        else return Center(child: Text('search'),);
                      },
                    ),
                  )

                ],
              ),
            ),
          );

        }
    );

  }
}
