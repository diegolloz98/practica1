
// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:practica1/user_page/bloc/blocImages/Images_bloc.dart';

import 'bloc/blocQuotes/quotes_bloc.dart';
import 'bloc/blocTime/Time_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var flags = ["ad", "mx", "pe", "ca", "ar"];
  var country = ["Andorra", "Mexico", "Peru", "Canada", "Argentina"];
  var numberOfElements = 5;

  
  @override
  Widget build(BuildContext context) {
    final urlImage = 'https://picsum.photos/200/300';
    return MaterialApp(
      title: 'La frase diaria',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          backgroundColor: Colors.purple,
          title: const Text("La frase diaria"),
          actions: <Widget>[
            BackdropToggleButton(
              color: Colors.purple,
              icon: AnimatedIcons.list_view,
            )
          ],
        ),
        backLayer: Container(
          margin: EdgeInsets.all(20) ,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: numberOfElements,
                itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 15),
                    RaisedButton(
                    onPressed: () => {
                      BlocProvider.of<TimeBloc>(context).index = index,
                      BlocProvider.of<TimeBloc>(context).add(TimePullToRefreshEvent()),
                    },
                    // padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20 ),
                      child:Row(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Image.network(
                                'https://flagcdn.com/32x24/${flags[index]}.png',
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only( left: 10.0 ),
                              child: Text(
                                "${country[index]}",
                                style: TextStyle( fontSize: 20.0),
                              )
                          )
                        ],
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)
                    ),
                  ),
                  ]
                );
              }
            )
              
            ),
          ),
          frontLayer: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(urlImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
                ),
            ),
            
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15),
              BlocConsumer<TimeBloc, TimeState>(
                listener: (context, state) {},
                builder: (context, state){
                  print(state);
                  if(state is TimeLoadedState){
                    return Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Text(
                        state.time,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45.0,
                        ),
                      ),
                    );
                    }else if(state is TimeFailedToLoadState){
                      print("ERROR Time "+state.error);
                      return Center(child: Text(state.error));
                    }
                return Center(child: CircularProgressIndicator());
              }
            ),
              SizedBox(height: 220),
              BlocBuilder<QuotesBloc, QuotesState>(
                  builder: (context, state){
                    print(state);
                    if(state is LoadedState){
                      return ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.quotes.length,
                              itemBuilder: (context, index) {
                                //List<dynamic> cuentas = state.cuentas[index];
                                return Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Text(
                                    state.quotes[0]["q"] + "- "+ state.quotes[0]["a"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    )
                                  ),
                                );
                            },
                          );
                      }else if(state is FailedToLoadState){
                        print("ERROR "+state.error);
                        return Center(child: Text(state.error));
                      }
                  return Center(child: CircularProgressIndicator());
                }
              ),
            ],
          ),
        ),
      ),
          
          
        );
  }
}
