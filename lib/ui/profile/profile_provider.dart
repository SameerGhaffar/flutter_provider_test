import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/api_profile_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileProvider extends ChangeNotifier {
  final PagingController<int, ProfileUserData> pagingController =
      PagingController(firstPageKey: 1);

  getProfileList() {
    pagingController.addPageRequestListener((pageKey) {
      print("Requesting $pageKey");
      _getApiData(pageKey);
    });
  }


  // getApiProfileData() async {
  //   http.Response response = await http.get(Uri.parse(profileDataLink));
  //    var data = jsonDecode(response.body.toString());
  //   if(response.statusCode == 200){
  //   DataModel.fromJson(data);
  //
  //   }

  _getApiData(int pageKey) async {
    print("page key");
    print(pageKey);
    try {
      http.Response response = await http
          .get(Uri.parse('https://reqres.in/api/users?page=$pageKey'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("data is here");
        DataModel? dataModel;
        dataModel = DataModel.fromJson(data);
        print("object");
        print("length = ${dataModel?.data.length}");

        if (dataModel.data.isNotEmpty) {
          print("pageKey = $pageKey");
          pagingController.appendPage(dataModel!.data, pageKey + 1);
        }
        print("data model success");
        notifyListeners();
        print("notifies");
      }
    } catch (e) {
      print(e);
    }
  }

  SingleProfileData? singleProfileData ;

  singleUserNotFound() async {
    print("Single user not found ");
    http.Response response = await http
        .get(Uri.parse('https://reqres.in/api/users/23'));

    if(response.statusCode ==404){
      print("got response & response code is ${response.statusCode}");
      notifyListeners();
    }else{
      print("else");
    }
  }

  getSingleProfileFromApi() async {
   print("Single Profile data is loading ");
    http.Response response = await http
        .get(Uri.parse('https://reqres.in/api/users/2'));


    if(response.statusCode ==200){
      var data = jsonDecode(response.body.toString());

      singleProfileData = SingleProfileData.fromJson(data);

      notifyListeners();
    }else{
      print("else");
    }
  }
}
