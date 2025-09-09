import 'http_request_exception.dart';

class HttpThrottlingException extends HttpRequestException {
  HttpThrottlingException({
    required super.status,
    required super.title,
    required super.userMessage,
    super.timestamp,
    super.type,
    super.detail,
    super.objects,
  });
}
