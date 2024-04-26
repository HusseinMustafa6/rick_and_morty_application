import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rick_morty_api/business_logic/cubit/episodes_cubit.dart';
import 'package:rick_morty_api/constants/my_colors.dart';
import 'package:rick_morty_api/data/models/episode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_api/data/repositories/episode_repository.dart';
import 'package:rick_morty_api/data/web_services/characters_web_service.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_api/presentation/widgets/epsiode_card.dart';

class EpisodesScreen extends StatefulWidget {
  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  List<Episode> allEpisodes = [];
 

   Widget buildListView(){

    return ListView.builder(
      itemCount: allEpisodes.length,
      shrinkWrap: true,
      itemBuilder:(context,index){
       return EpisodeCard(allEpisodes[index]);
      });
   }


   Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodesCubit(EpisodeRepository(WebService())),
      child: BlocBuilder<EpisodesCubit, EpisodesState>(
        builder: (context, state) {
           BlocProvider.of<EpisodesCubit>(context).getAllEpisodes();
          if(state is EpisodesLoaded){
           allEpisodes = state.episodes;
            return SingleChildScrollView(
            child: Container(
              color: MyColors.myGrey,
              child: buildListView(),
            ),
          );
          }else{
            return buildLoadingIndicator();
          }
         
        },
      ),
    );
  }
}
