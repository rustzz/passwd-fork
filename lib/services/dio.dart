import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../utils/loggers.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio()..interceptors.add(LoggingInterceptor());
}

class LoggingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions request, RequestInterceptorHandler wrapper) async {
    Loggers.networkLogger.info(
      '${request.method} ${request.uri.toString()}',
    );
    return super.onRequest(request, wrapper);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler wrapper) async {
    Loggers.networkLogger.info(
      '${response.requestOptions.uri.toString()} ${response.statusCode} - ${response.data}',
    );
    return super.onResponse(response, wrapper);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler wrapper) async {
    Loggers.networkLogger.severe(
      '${error.message} - ${error.requestOptions.method} ${error.requestOptions.uri.toString()}',
    );
    return super.onError(error, wrapper);
  }
}
