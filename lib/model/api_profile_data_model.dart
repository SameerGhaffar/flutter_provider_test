class DataModel {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<ProfileUserData> data;
  Support support;

  DataModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataJson = json['data'];
    final data = dataJson.map((item) => ProfileUserData.fromJson(item))
        .toList();

    return DataModel(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: data,
      support: Support.fromJson(json['support']),
    );
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> dataJson = data.map((item) =>
        item.toJson()).toList();

    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': dataJson,
      'support': support.toJson(),
    };
  }
}

class SingleProfileData {
  ProfileUserData data;
  Support support;

  SingleProfileData({required this.data, required this.support});

  factory SingleProfileData.fromJson(Map<String, dynamic> json) {

    return SingleProfileData(
    data: ProfileUserData.fromJson(json['data']),
    support: Support.fromJson(json['support'])
    ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'support': support.toJson(),
    };
  }

}

class ProfileUserData {
  int id;
  String email;
  String firstName;
  String lastName;
  String networkImage;

  ProfileUserData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.networkImage,
  });

  factory ProfileUserData.fromJson(Map<String, dynamic> json) {
    return ProfileUserData(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      networkImage: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': networkImage,
    };
  }
}

class Support {
  String url;
  String text;

  Support({required this.url, required this.text});

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'text': text,
    };
  }
}

