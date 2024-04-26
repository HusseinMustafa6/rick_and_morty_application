import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_api/data/models/episode.dart';
import 'package:rick_morty_api/data/repositories/episode_repository.dart';

part 'episodes_state.dart';

class EpisodesCubit extends Cubit<EpisodesState> {
  
  final EpisodeRepository episodeRepository;
  List<Episode> episodes = [];

  EpisodesCubit(this.episodeRepository) : super(EpisodesInitial());
  
  List<Episode> getAllEpisodes(){
    episodeRepository.getAllEpisodes().then((episodesList){
      
     if(episodesList.isEmpty){
      emit(EpisodesInitial());
     }else{
      emit(EpisodesLoaded(episodesList));
     }
     this.episodes = episodesList;
    });
    return episodes;
  }
  




}
