class UserModel {
  String id;
  String email;
  String name;
  int createAt;

  UserModel({
    this.id = '',
    required this.email,
    required this.name,
    required this.createAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id : json['id'],
        email : json['email'],
        name : json['name'],
        createAt : json['createAt'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'createAt': createAt,
  };
}
