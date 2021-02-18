import 'package:fim_guinee/src/api_files/provider/models/dataModel.dart';
import 'package:fim_guinee/src/api_files/provider/services/fimAPI.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class FimProvider with ChangeNotifier{
  FimModel _fimModel = FimModel(
    sliders: [],
    recents: [],
    others: [],
    populaires: [],
    teams: [],
    videos: [],
  );

  FimAPI _fimAPI = FimAPI();
  FimModel get fimModel => _fimModel;

  set fimModel(FimModel fimModel){
    _fimModel = fimModel;
    notifyListeners();
  }

  Future<void> fetchFimData() async{
    fimModel = await _fimAPI.fetchFimData();
  }

}