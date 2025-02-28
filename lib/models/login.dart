class Login {
  final String userId;
  final String schoolCode;
  final String password;
  final bool isLoading;
  final String? error;
  final String? token;

  Login(
      {this.userId = '',
      this.schoolCode = '',
      this.password = '',
      this.isLoading = false,
      this.error,
      this.token});

  Login copyWith({
    String? userId,
    String? schoolCode,
    String? password,
    bool? isLoading,
    String? error,
    String? token,
  }) {
    return Login(
        userId: userId ?? this.userId,
        schoolCode: schoolCode ?? this.schoolCode,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        token: token ?? this.token);
  }
}
