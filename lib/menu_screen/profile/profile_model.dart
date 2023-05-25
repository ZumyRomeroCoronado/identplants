class ProfileModel {
  ProfileModel({
    required this.users,
  });

  final Users users;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        users: Users.fromJson(json["Users"]),
      );
}

class Users {
  Users({
    required this.password,
    required this.foto,
    required this.name,
    required this.email,
  });

  final String password;
  final String foto;
  final String name;
  final String email;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        password: json["password"],
        foto: json["foto"],
        name: json["name"],
        email: json["email"],
      );
}
