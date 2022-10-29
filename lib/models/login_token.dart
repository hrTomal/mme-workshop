class LoginToken {
  late final String refresh;
  late final String access;

  LoginToken(
    this.refresh,
    this.access,
  );

  LoginToken.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }
}
