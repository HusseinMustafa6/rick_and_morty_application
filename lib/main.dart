import 'package:flutter/material.dart';
import 'package:rick_morty_api/app_router.dart';

void main() {
  runApp(RickMortyApp(AppRouter()));
}



class RickMortyApp extends StatelessWidget {
  
  final AppRouter appRouter;
  
  RickMortyApp(this.appRouter);

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       onGenerateRoute: appRouter.GenrateRoute,
     );    
  }
}