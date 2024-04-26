import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_api/data/models/character.dart';
import 'package:rick_morty_api/data/repositories/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

   final CharactersRepository charactersRepository;
   List<Character> characters = []; 
   
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  
  List<Character> getAllCharacter(){
     charactersRepository.getAllCharacters().then((charactersList){
          
         emit(CharactersLoaded(charactersList));
         this.characters = charactersList;
     });
     return characters;
  }




}
