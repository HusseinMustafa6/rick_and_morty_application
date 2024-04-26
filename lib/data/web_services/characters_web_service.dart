




import 'package:dio/dio.dart';
import 'package:rick_morty_api/constants/strings.dart';

class WebService{
  
  // we will handle all api calls in this class
  // each function will represnt an api call

  late Dio dio;
  
  WebService(){
   
   BaseOptions options = BaseOptions(
     baseUrl: baseurl,
     receiveDataWhenStatusError: false,
     connectTimeout: Duration(seconds: 20),
     receiveTimeout: Duration(seconds: 20),  
   );
   
    dio = Dio(options);

  }  
  
  
  Future<List<dynamic>> getAllCharacters()async{
     
     List<dynamic> allCharacters = []; 
     Response response;
    try{
      for(int i = 1 ; i <= 6 ; i++){
        response = await dio.get('character?page=${i}');
         allCharacters.addAll(response.data['results']);
      }

  
   return allCharacters;
    }catch(e){
      print(e.toString());
      return [];
    }

  }
 
 Future<List<dynamic>> getAllEpisodes()async{

   List<dynamic> allEpisodes = [];
   Response  response;
   try{ 
    for(int i = 1 ; i <= 3 ; i++){
       response  = await dio.get('episode?page=${i}');
       allEpisodes.addAll(response.data['results']); 

    } 
   return allEpisodes;
   }catch(e){
    print(e);
    return [];
   }
   



 }




}



