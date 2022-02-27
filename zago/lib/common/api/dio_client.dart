import 'package:dio/dio.dart';
import 'package:zago/common/abstract/my_loc.dart';
import 'package:zago/common/api/base_api.dart';

class Api {
  static final instance = Api.createDio();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: MyURL.baseURL,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(),
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    dlog(
        '=================================== \nRequest: ${options.method}\n -> Path: ${MyURL.baseURL}${options.path}\n -> Param: ${options.data}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    dlog(
        '=================================== \nResponse code: ${response.statusCode}\nResponse message: ${response.statusMessage}\n -> Result: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    dlog(
        '=================================== \nError: ${err.requestOptions.path}\n -> Error message: ${err.message}');
    return super.onError(err, handler);
  }
}
