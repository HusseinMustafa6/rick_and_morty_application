

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_api/business_logic/cubit/characters_cubit.dart';
import 'package:rick_morty_api/business_logic/cubit/episodes_cubit.dart';
import 'package:rick_morty_api/constants/strings.dart';
import 'package:rick_morty_api/data/models/character.dart';
import 'package:rick_morty_api/data/repositories/characters_repository.dart';
import 'package:rick_morty_api/data/repositories/episode_repository.dart';
import 'package:rick_morty_api/data/web_services/characters_web_service.dart';
import 'package:rick_morty_api/presentation/screens/character_info.dart';
import 'package:rick_morty_api/presentation/screens/characters_screen.dart';
import 'package:rick_morty_api/presentation/screens/episodes_screen.dart';

class AppRouter{
 
 late CharactersRepository charactersRepository;
 late CharactersCubit charactersCubit;

 late EpisodeRepository episodeRepository;
 late EpisodesCubit episodesCubit;

  AppRouter(){
    charactersRepository = CharactersRepository(WebService());
    charactersCubit = CharactersCubit(charactersRepository);
     
    episodeRepository = EpisodeRepository(WebService());
    episodesCubit = EpisodesCubit(episodeRepository);

  } 


Route? GenrateRoute(RouteSettings settings){
   
   switch(settings.name){
     case  charactersScreen:
     return MaterialPageRoute(builder: (_)=> BlocProvider(create: (context)=> charactersCubit,child: CharactersScreen(),));
     case  characterInfo:
     final selectedCharacter = settings.arguments as Character;
     return MaterialPageRoute(builder: ((_) => CharactersInfo(character: selectedCharacter,) ));
     case episodesScreen:
     return MaterialPageRoute(builder: (_)=> EpisodesScreen());      
   }



}




}