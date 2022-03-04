
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc/blocQuotes/quotes_bloc.dart';
import 'bloc/blocTime/Time_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //final urlImage = 'https://i.redd.it/d3j78k2wgjj11.png';
    Widget button(String s, String n){
      return RaisedButton(
          onPressed: () => {
            print(n)
          },
          // padding: const EdgeInsets.all(0.0),
          child: Container(
            
            padding: const EdgeInsets.only(top: 20.0, bottom: 20 ),
            child:Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Image.network(
                      s,
                    )
                ),
                Container(
                    margin: const EdgeInsets.only( left: 10.0 ),
                    child: Text(
                      n,
                      style: TextStyle( fontSize: 20.0),
                    )
                )
              ],
            ),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)
          )
        );
    }
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
            
            child: Column(
                
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  button('https://flagcdn.com/16x12/ad.png', "Andorra"),
                  SizedBox(height: 15),
                  button('https://flagcdn.com/16x12/mx.png', "Mexico"),
                  SizedBox(height: 15),
                  button('https://flagcdn.com/16x12/pe.png', "Peru"),
                  SizedBox(height: 15),
                  button('https://flagcdn.com/16x12/ca.png', "Canada"),
                  SizedBox(height: 15),
                  button('https://flagcdn.com/16x12/ar.png', "Argentina"),
                ]
            ),
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
              BlocBuilder<TimeBloc, TimeState>(
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
