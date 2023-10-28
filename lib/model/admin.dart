class Admin {
  String name;
  int phone;
  int password;

  Admin({required this.name, required this.password, required this.phone});

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        name: json['name'],
        password: json['password'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'password': password,
        'phone': phone,
      };
}
