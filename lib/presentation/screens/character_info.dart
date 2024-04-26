import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rick_morty_api/constants/my_colors.dart';
import 'package:rick_morty_api/data/models/character.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CharactersInfo extends StatelessWidget {
  final Character character;

  CharactersInfo({required this.character});

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      thickness: 1.2,
      color: MyColors.myYellow,
    );
  }

  Widget buildCharacterAttribute(String key, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: key,
            style: TextStyle(
                color: MyColors.myWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            )),
      ]),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      elevation: 2,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        background: Hero(
          tag: character.id,
          child: Container(
            color: MyColors.myGrey,
            child: character.image.isNotEmpty
                ? Image.network(
                    character.image,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/place_holder.jpg'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCharacterAttribute('Species : ', character.species),
                    buildDivider(300),
                    buildCharacterAttribute('Gender : ', character.gender),
                    buildDivider(260),
                    buildCharacterAttribute('Status : ', character.status),
                    buildDivider(255),
                    buildCharacterAttribute(
                        'Origin : ', character.origin['name']),
                    buildDivider(290),
                    buildCharacterAttribute(
                        'Created At : ', character.createdAt),
                    buildDivider(220),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250.0,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 7.0,
                              color: Colors.white,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FlickerAnimatedText(character.name),
                          ],
                          onTap: () {
                        
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
