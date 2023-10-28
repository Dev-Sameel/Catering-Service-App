class UserData {
  String photo;
  String? id;
  String name;
  String address;
  String dob;
  int? mobile;
  int? password;
  String bloodGroup;
  List<WorkCategory>? confirmedWork;

  UserData({
    this.id,
    this.confirmedWork,
    required this.bloodGroup,
    required this.photo,
    required this.name,
    required this.address,
    required this.dob,
    required this.mobile,
    required this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json,String? id) => UserData(
        confirmedWork: List<WorkCategory>.from(
            (json['work'] ?? []).map((x) => WorkCategory.fromMap(x))),
        photo: json['photo'],
        name: json["name"],
        address: json["address"],
        id: id,
        bloodGroup: json["bloodGroup"],
        dob: json["dob"],
        mobile: json["mobile"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "confirmedWork": confirmedWork?.map((w) => w.toMap()).toList() ?? [],
        "photo": photo,
        "name": name,
        "address": address,
        "bloodGroup": bloodGroup,
        "dob": dob,
        "mobile": mobile,
        "password": password,
        'id':id
      };
}

class WorkCategory {
  String workid;
  String busfare;

  WorkCategory({
    required this.workid,
    required this.busfare,
  });

  factory WorkCategory.fromMap(Map<String, dynamic> map) {
    return WorkCategory(
      workid: map['workid'] ?? '',
      busfare: map['busfare'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workid': workid,
      'busfare': busfare,
    };
  }
}
