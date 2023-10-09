class GeneralAuthResponse<T> {
  bool? status;
  int? code;
  String? message;
  Map<String, dynamic>? user;

  GeneralAuthResponse({this.status, this.code, this.message, this.user});

  GeneralAuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    user = json['user'];
  }
}
