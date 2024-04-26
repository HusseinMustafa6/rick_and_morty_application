class Character {

  
  late int id;
  late String name;
  late String status;
  late String species;
  late String gender;
  late String image;
  late String createdAt;

  late Map<String,dynamic> origin;

  Character.fromJson(Map<String , dynamic> jsonObj){
     
     id = jsonObj['id'];
     name = jsonObj['name'];
     status = jsonObj['status'];
     species = jsonObj['species'];
     gender = jsonObj['gender'];
     image = jsonObj['image'];
     createdAt = jsonObj['created'];

     origin = jsonObj['origin'];

  }





}