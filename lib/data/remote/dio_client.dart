import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore/data/local/secured_storage.dart';
import 'package:bookstore/data/remote/interceptors/log_interceptor.dart';
import 'package:bookstore/features/auth/bloc/auth_bloc.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/helpers/overlay_helper.dart';
import 'package:bookstore/helpers/routes.dart';
import 'package:bookstore/models/api/response_model.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:bookstore/settings/enums.dart';
import 'package:bookstore/settings/globals.dart';

mixin DioClientMixin {
  final _DioClient _dio = _DioClient();
  _DioClient get dio => _dio;
}

class _DioClient {
  _DioClient({
    String? baseUrl,
    ResponseType? type,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? EndPoints.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
            responseType: type ?? ResponseType.json,
          ),
        )..interceptors.addAll(
            [
              LoggerInterceptor(),
              InterceptorsWrapper(
                onResponse: (res, handler) {
                  'end response'.log();
                  handler.next(res);
                },
                onRequest: (options, handler) async {
                  handler.next(options);
                },
                onError: (e, handler) async {
                  handler.next(e);
                },
              )
            ],
          );

  late final Dio _dio;
  Options addHeaders(Options? options) {
    final token = LocalStorage.getToken;
    final langHead = {
      'Accept': 'application/json',
      'Accept-Language': locale.value == 'tr' ? 'tk' : locale.value,
      'Authorization': 'Bearer $token',
    };
    if (options == null) return Options(headers: langHead);
    return options.copyWith(
      headers: options.headers!..addAll(langHead),
    );
  }

  Future<ApiResponse> post({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        endPoint,
        data: data,
        options: addHeaders(options),
      );
      return ApiResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (e, s) {
      'zero Step'.log();

      return _handleException(e, s);
    }
  }

  Future<ApiResponse> get({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.get<dynamic>(
        endPoint,
        data: data,
        options: addHeaders(options),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return ApiResponse.fromJson(res.data as Map<String, dynamic>);
    } catch (e, s) {
      'ERROR GET'.log();
      return await _handleException(e, s);
    }
  }

  Future<ApiResponse> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endPoint,
        data: data,
        options: addHeaders(options),
        queryParameters: queryParameters,
      );
      return ApiResponse.fromJson(response.data);
    } catch (e, s) {
      e.log();
      return _handleException(e, s);
    }
  }
}

Future<ApiResponse> _handleException(Object e, StackTrace? stack) async {
  final isDioExeption = e is DioException;
  final seMessaeg = appRouter.currentContext.l10n.socketExeption;

  if (!isDioExeption) {
    SnackBarHelper.showTopSnack(
      seMessaeg,
      APIState.error,
    );
    return ApiResponse.unknownError;
  }
  if (e.response != null && e.response!.statusCode == 401) {
    await appRouter.currentContext.read<AuthBloc>().deleteToken();
  }
  if (e.response != null && e.response!.data is Map) {
    '${e.requestOptions.data} MyDioExeption'.log();
    SnackBarHelper.showTopSnack(
      e.response!.data['message'] ?? seMessaeg,
      APIState.error,
    );
    return ApiResponse.fromJson(e.response!.data);
  }
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.cancel) return ApiResponse.unknownError;
  SnackBarHelper.showTopSnack(
    seMessaeg,
    APIState.error,
  );
  return ApiResponse.unknownError;
}
