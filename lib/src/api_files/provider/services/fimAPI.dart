// import 'dart:html';

import 'package:fim_guinee/src/api_files/mesConst.dart';
import 'package:fim_guinee/src/api_files/provider/models/dataModel.dart';
import 'package:http/http.dart';

class FimAPI{
  Client _client = Client();

  fetchFimData() async {
    Response response = await _client.get('$url/home');
    if(response.statusCode ==200){
      print('Les données ont été recuperées');
      return fimModelFromJson(response.body);
    }
    print("Les données n'ont pas été récuperées");
    return FimModel(
      sliders: [],
      recents: [],
      populaires: [],
      videos: [],
      others: [],
      teams: [],
    );
  }
}