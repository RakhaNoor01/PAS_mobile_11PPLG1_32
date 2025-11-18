class LoginModel {
  String? username;
  String? password;
  String? token;
  bool isLoggedIn;

  LoginModel({
    this.username,
    this.password,
    this.token,
    this.isLoggedIn = false,
  });

  // Validasi Login (Admin123) - fallback if API fails
  static bool validate(String username, String password) {
    return username == 'Admin123' && password == 'Admin123';
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'token': token,
        'isLoggedIn': isLoggedIn,
      };

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json['username'],
        password: json['password'],
        token: json['token'],
        isLoggedIn: json['isLoggedIn'] ?? false,
      );
}
