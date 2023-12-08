class DataModel {
  String? name;
  num? id;
  num? timeZone;

  DataModel({
    this.name,
    this.id,
    this.timeZone,
  });

  DataModel.fromJson(json) {
    id = json['id'];
    timeZone = json['timeZone'];
    name = json['name'];
  }
}

class UserData {
  String? name;
  String? address;
  String? phone;
  String? email;
  UserData({
    this.name,
    this.address,
    this.phone,
    this.email,
  });
  
}
