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

  getSingleProfileFromApi() async {
    print("get single api ");
    http.Response response = await http
        .get(Uri.parse('https://reqres.in/api/users/2'));
    print("get data ");

    if(response.statusCode ==200){
      var data = jsonDecode(response.body.toString());
      print("data == $data");
      singleProfileData = SingleProfileData.fromJson(data);
      print(singleProfileData!.data.email);
      notifyListeners();
    }else{
      print("else");
    }
  }
}
