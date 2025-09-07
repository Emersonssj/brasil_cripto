import 'package:result_dart/result_dart.dart';

import 'exceptions/http_list_exceptions.dart' show HttpRequestException;
import 'http_response.dart';

abstract class HttpService {
  AsyncResult<HttpResponse, HttpRequestException> get(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  });

  AsyncResult<HttpResponse, HttpRequestException> post(
    String path, {
    Duration? requestTimeout,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  });

  AsyncResult<HttpResponse, HttpRequestException> put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  });

  AsyncResult<HttpResponse, HttpRequestException> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  });
}
