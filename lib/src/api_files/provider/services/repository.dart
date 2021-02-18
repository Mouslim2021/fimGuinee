import 'package:fim_guinee/src/api_files/provider/fimProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Repository {
  Future<void> fetchFimData (BuildContext context) async{
    FimProvider fimProvider = Provider.of(context, listen: false);
    await fimProvider.fetchFimData();
  }
   
}