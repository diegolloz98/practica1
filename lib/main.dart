import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/user_page/bloc/blocQuotes/quotes_bloc.dart';
import 'package:practica1/user_page/bloc/blocTime/Time_bloc.dart';
import 'package:practica1/user_page/homePage.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              return QuotesBloc()..add(LoadEvent());
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return TimeBloc()..add(TimeLoadEvent());
            },
          ),
        ],
        child: MaterialApp(
          home: HomePage(),
        ),
      );
  }
}
