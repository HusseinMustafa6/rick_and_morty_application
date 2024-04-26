


import 'package:rick_morty_api/data/models/episode.dart';
import 'package:rick_morty_api/data/web_services/characters_web_service.dart';
import 'package:rick_morty_api/presentation/widgets/epsiode_card.dart';

class EpisodeRepository {

  
  late WebService webService;
   
   EpisodeRepository(this.webService);
 

  
  Future<List<Episode>> getAllEpisodes()async{

   final allEpisodes = await webService.getAllEpisodes();    
      
    
   return allEpisodes.map((episode) => Episode.fromJson(episode)).toList(); 

  }
  



}