import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rick_morty_api/business_logic/cubit/characters_cubit.dart';
import 'package:rick_morty_api/constants/my_colors.dart';
import 'package:rick_morty_api/data/models/character.dart';
import 'package:rick_morty_api/presentation/screens/episodes_screen.dart';
import 'package:rick_morty_api/presentation/widgets/character_card.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
   List<Character> allCharacters = [];
   List<Character> searchedCharacters = [];
  bool _isSearching = false;
  final textController = TextEditingController();
  
  int selecetedindex = 0;
  

  Widget buildOfflineWidget(){
    return Center(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Can\'t Connect... check connection',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }

  AppBar buildEpisodeAppBar(){
    return AppBar(
        backgroundColor: MyColors.myYellow,
        leading: Container(),
        title: Text(
          'Episodes',
          style: TextStyle(
              fontSize: 18, fontFamily: 'Smokum', color: MyColors.myGrey),
        ),
      );
  }

  List<Widget> buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                searchedCharacters.clear();
                textController.clear();
              });
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void addSearchedCharactersToSearchedList(String searchedValue) {

   setState(() {
     searchedCharacters = allCharacters
        .where(
            (element) => element.name.toLowerCase().startsWith(searchedValue))
        .toList();
   });

    
  }

  Widget buildSearchTextFiled() {
    return TextField(
      controller: textController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        helperStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
        border: InputBorder.none ,
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedValue) {
        addSearchedCharactersToSearchedList(searchedValue);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacter();
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchedCharacters.isEmpty ? allCharacters.length : searchedCharacters.length,
        itemBuilder: (context, index) {
          if(searchedCharacters.isEmpty){
          return CharacterCard(allCharacters[index]);
          }else{
            return CharacterCard(searchedCharacters[index]);
          }

        });
  }

  Widget buildGridViewWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildBlocBuilder() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildGridViewWidget();
      } else {
        return buildLoadingIndicator();
      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selecetedindex == 0 ? AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    searchedCharacters.clear();
                    textController.clear();
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: MyColors.myGrey,
                ))
            : Container(),
        title: _isSearching ? buildSearchTextFiled() :Text(
          'Characters',
          style: TextStyle(
              fontSize: 18, fontFamily: 'Smokum', color: MyColors.myGrey),
        ),
        actions: buildAppBarActions(),
      ) : buildEpisodeAppBar(),
      body: SafeArea(
        child: OfflineBuilder(
             connectivityBuilder: (BuildContext context, ConnectivityResult value, Widget child) {
               final bool connected = value != ConnectivityResult.none;

               if(connected){
                 return selecetedindex == 0 ?  buildBlocBuilder() : EpisodesScreen();
               }else{
                 return buildOfflineWidget();
               }

             },
         child: buildOfflineWidget(),
        )
      ),
      bottomNavigationBar: GNav(
  
        selectedIndex: selecetedindex,
        backgroundColor: MyColors.myYellow,
        onTabChange: (index){
          setState(() {
            selecetedindex = index;
          });
          
        },
        tabs: [
          GButton(icon: Icons.people, text: 'Characters',textColor: MyColors.myGrey , onPressed: (){

          },),
           GButton(icon: Icons.list_alt_outlined , text: 'Episodes',textColor: MyColors.myGrey , onPressed: (){

          },)
        ],
        tabBackgroundGradient: LinearGradient(
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
           colors: [Colors.yellow , Colors.yellow[500]!]),
        rippleColor: Colors.grey[300]!, 
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: MyColors.myGrey ,
        iconSize: 26,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: MyColors.myGrey,
        tabMargin: EdgeInsets.symmetric(vertical: 5),
      
        
        ),
    );
  }
}


//