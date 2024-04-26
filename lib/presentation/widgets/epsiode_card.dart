import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rick_morty_api/constants/my_colors.dart';
import 'package:rick_morty_api/data/models/episode.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  EpisodeCard(this.episode);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        margin: EdgeInsetsDirectional.all(5.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          color: MyColors.myWhite,
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: MyColors.myGrey,
                radius: 30.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      episode.episodeNumber,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            title: Text(episode.title,style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold),),
            subtitle: Text(episode.airDate),
          ),
        ));
  }
}
