class LoginStateModel {
  final String? userName;
  AuthStatus? status;
  final String? message;

  LoginStateModel({this.userName, this.status, this.message});

  LoginStateModel copyWith({
    AuthStatus? status,
    String? error,
    String? userName,
  }) {
    return LoginStateModel(
      status: status ?? this.status,
      message: error,
      userName: userName ?? this.userName,
    );
  }
}

enum AuthStatus { success, error }
