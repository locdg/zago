class MyURL {
  static const baseURL = 'https://jsonplaceholder.typicode.com';
}

class BaseResponse<T> {
  final int statusCode;
  final String statusMessage;
  final T data;

  BaseResponse(this.statusCode, this.statusMessage, this.data);

  BaseResponse.fromJson(Map<String, dynamic> json)
      : statusCode = json[KeyResposne.statusCode] ?? 0,
        statusMessage = json[KeyResposne.statusMessage] ?? "",
        data = json[KeyResposne.data] ?? "";

  Map<String, dynamic> toJson() => <String, dynamic>{
        KeyResposne.statusCode: statusCode,
        KeyResposne.statusMessage: statusMessage,
        KeyResposne.data: data,
      };
}

class KeyResposne {
  static const statusCode = "statusCode";
  static const statusMessage = "statusMessage";
  static const data = "data";
}
