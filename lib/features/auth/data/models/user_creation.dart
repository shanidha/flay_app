class UserCreationReq {
  String? userName;
  String? email;
  String? password;
  int? gender;

  UserCreationReq({
    required this.userName,
    required this.email,
    required this.password,
    required this.gender
  });
}
