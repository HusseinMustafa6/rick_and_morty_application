
class Episode{

  late int id;
  late String title;
  late String airDate;
  late String episodeNumber;

  Episode.fromJson(Map<String,dynamic> jsonMap){
     id = jsonMap['id'];
     title = jsonMap['name'];
     airDate = jsonMap['air_date'];
     episodeNumber = jsonMap['episode']; 

  }
  

    



}