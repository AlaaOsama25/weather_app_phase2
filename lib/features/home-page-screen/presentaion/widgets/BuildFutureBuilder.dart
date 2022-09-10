import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/utils/climat-class-model/response-model.dart';
import '../../../../core/utils/cubit/cubit.dart';

FutureBuilder<Weather> buildfuturebuilder (dynamic response) {
  return FutureBuilder<Weather>(
    future: response,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        var apidate = snapshot.data!.location?.localtime!;
        print(apidate);
        var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
        var dayFormat = DateFormat('yyyy-MM-dd');
        var inputDate = inputFormat.parse(apidate!);// <-- dd/MM 24H format
        var DayOfDate=DateFormat('EEEE').format(inputDate);
        print(DateFormat('EEEE').format(inputDate)); // Sunday

        DateTime tempDate = DateFormat("hh:mm").parse(snapshot.data!.location!.localtime!.substring(11,snapshot.data!.location!.localtime!.length==16? 16 :15).trim());
        var dateFormat = DateFormat("h:mm a");
        var hourformat= DateFormat("h a");
        var Date12Format=dateFormat.format(tempDate);// you can change the format here
        print(dateFormat.format(tempDate));


        return
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${snapshot.data!.current!.tempC!.round().toString()}°',
                              style: TextStyle(fontSize: 60,color: Colors.white),
                            ),
                            Spacer(),
                            Image.network('https:${snapshot.data!.current!.condition!.icon}',width: 80,height: 80,),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            (snapshot.data!.location!.region.toString()=="")? Text(snapshot.data!.location!.name.toString().toUpperCase(),
                              style: TextStyle(fontSize: 20,color: Colors.white),
                            ) : Text(snapshot.data!.location!.region.toString().toUpperCase(),
                              style: TextStyle(fontSize: 20,color: Colors.white),
                            ),
                            SizedBox(width: 5,),
                            Icon(Icons.location_on_rounded, color: Colors.white,size: 18,),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Text(
                          '${snapshot.data!.forecast!.forecastday![0]!.day!.maxtempC!.round().toString()}° / ${snapshot.data!.forecast!.forecastday![0]!.day!.mintempC!.round().toString()}° Feels like ${snapshot.data!.current!.feelslikeC!.round().toString()}° ',
                          style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        Text('${DayOfDate.substring(0,3)}, ${Date12Format.toLowerCase()}',
                          style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 210,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.forecast!.forecastday![0]!.hour!.length,
                            itemBuilder: ((context, index) => Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                children: [
                                  SizedBox(height: 15,),
                                  Text(
                                    '${hourformat.format(DateFormat("hh:mm").parse(snapshot.data!.forecast!.forecastday![0]!.hour![index]!.time!.substring(11,snapshot.data!.location!.localtime!.length==16? 16 :15).trim().toString())).toLowerCase()}',
                                    style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5,),
                                  Image.network('https:${snapshot.data!.forecast!.forecastday![0]!.hour![index]!.condition!.icon}'),
                                  Text(
                                    '${snapshot.data!.forecast!.forecastday![0]!.hour![index]!.tempC!.round().toString()}°',
                                    style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                SizedBox(height: 40),
                                  Row(
                                    children: [
                                      Icon(Icons.water_drop_outlined,color: Colors.white,size: 15,),
                                      Text(
                                        '${snapshot.data!.forecast!.forecastday![0]!.hour![index]!.humidity.toString()}%',
                                        style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ))),
                      )

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Today`s Temperature',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          Text('Expect the same as Yesterday',style: TextStyle(fontSize: 15,color: Colors.white),)

                        ],
                      ),
                    ),


                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 400,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(width:90,child: Text('Today',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),
                              Row(
                                children: [
                                  Icon(Icons.water_drop_outlined,color: Colors.white,size: 15,),
                                  SizedBox(width: 5,),
                                  Text(
                                    '${snapshot.data!.current!.humidity.toString()}%',
                                    style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),                                    ),
                                ],
                              ),
                              Image.network('https:${snapshot.data!.forecast!.forecastday![0]!.hour![11]!.condition!.icon}',width: 40,height: 40,),
                              Image.network('https:${snapshot.data!.forecast!.forecastday![0]!.hour![0]!.condition!.icon}',width: 50,height: 50,),
                              Text(
                                '${snapshot.data!.forecast!.forecastday![0]!.day!.maxtempC!.round().toString()}°',
                                style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${snapshot.data!.forecast!.forecastday![0]!.day!.mintempC!.round().toString()}°',
                                style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                              ),

                            ],
                          ),
                          Container(
                            height: 300,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: 6,
                                itemBuilder: ((context,index) =>
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(width:90,child: Text('${DateFormat('EEEE').format(dayFormat.parse(snapshot.data!.forecast!.forecastday![index+1]!.date!))}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),
                                        Row(
                                          children: [
                                            Icon(Icons.water_drop_outlined,color: Colors.white,size: 15,),
                                            SizedBox(width: 5,),
                                            Text(
                                              '${snapshot.data!.forecast!.forecastday![index+1]!.hour![0]!.humidity.toString()}%',
                                              style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),                                    ),
                                          ],
                                        ),
                                        Image.network('https:${snapshot.data!.forecast!.forecastday![index+1]!.hour![11]!.condition!.icon}',width: 40,height: 40,),
                                        Image.network('https:${snapshot.data!.forecast!.forecastday![index+1]!.hour![0]!.condition!.icon}',width: 50,height: 50,),
                                        Text(
                                          '${snapshot.data!.forecast!.forecastday![index+1]!.day!.maxtempC!.round().toString()}°',
                                          style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${snapshot.data!.forecast!.forecastday![index+1]!.day!.mintempC!.round().toString()}°',
                                          style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                                        ),

                                      ],
                                    )
                                )
                            ),
                          )

                        ],
                      ),
                    ),


                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 170,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Sunrise',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text('${snapshot.data!.forecast!.forecastday![0]!.astro!.sunrise!.toLowerCase()}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                Image.asset('images/sunrise.png',width: 90,height: 90,),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Sunset',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text('${snapshot.data!.forecast!.forecastday![0]!.astro!.sunset!.toLowerCase()}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                Image.asset('images/sunset.png',width: 90,height: 90,),
                              ],
                            ),
                          ],
                        ),
                      )


                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 130,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.wb_sunny,color: Colors.orangeAccent,size: 40,),
                                SizedBox(height: 10,),
                                Text('UV index',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                Text('${snapshot.data!.current!.uv!.round()}',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),



                              ],
                            ),
                            Container(color: Colors.grey,height:60,width: 2,),
                            Column(
                              children: [
                                Icon(Icons.air,color: Colors.white,size: 40,),
                                SizedBox(height: 10,),
                                Text('Wind',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                Text('${snapshot.data!.current!.wind_kph!.round()} Km/h',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),

                              ],
                            ),
                            Container(color: Colors.grey,height:60,width: 2,),
                            Column(
                              children: [
                                Icon(Icons.water_drop,color: Colors.blueAccent,size: 40,),
                                SizedBox(height: 10,),
                                Text('Humidity',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                Text('${snapshot.data!.current!.humidity!.round()}%',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),

                              ],
                            )


                          ],
                        ),
                      )


                  ),
                ),



              ]
          );
      }
      else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      else {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    },
  );
}
