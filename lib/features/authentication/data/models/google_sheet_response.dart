class GoogleSheetResponse {
  final bool hasError;
  final Map<String, dynamic>? data;
  final String msg;
  final int code;

  GoogleSheetResponse({
    required this.hasError,
    required this.data,
    required this.msg,
    required this.code,
  });

  factory GoogleSheetResponse.fromJson(Map<String, dynamic> json) {
    return GoogleSheetResponse(
      hasError: json['hasError'],
      data: json['data'],
      msg: json['msg'],
      code: json['code'],
    );
  }
}