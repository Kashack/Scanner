class LoginModel{
  final String? successful;
  final String? errorMessage;
  final String? result;
  final String? warningResult;
  final String? errorResult;

  LoginModel(
      {this.successful,
      this.errorMessage,
      this.result,
      this.warningResult,
      this.errorResult});

  factory LoginModel.fromErrorJson(Map<String, dynamic> json) {
    return LoginModel(
      successful: json['userId'],
      errorMessage: json['id'],
      result: json['title'],
    );
  }
}