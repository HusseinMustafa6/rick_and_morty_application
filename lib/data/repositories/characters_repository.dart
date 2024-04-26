


import 'dart:developer';

import 'package:rick_morty_api/data/models/character.dart';
import 'package:rick_morty_api/data/web_services/characters_web_service.dart';

class CharactersRepository{
   //in this class we store the data we get from the server
   // and also we model it
  
  WebService webService;

  CharactersRepository(this.webService);
   

  Future<List<Character>> getAllCharacters()async{
    Character temp;
    int counter = 0;
    List<Character> modeledCharacters = []; 

   final characters = await webService.getAllCharacters(); 

    for(var c in characters){
        temp = Character.fromJson(c);
        modeledCharacters.add(temp); 
        print(temp);
        print('Counter ${counter}');
    }


     return characters.map((c) => Character.fromJson(c)).toList(); 
  }
  



}