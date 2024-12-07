import 'package:dio/dio.dart';
import 'package:bookstore.tm/models/api/response_model.dart';

abstract class NotificationsRepo {
  Future<ApiResponse> getNotificationsList(
    CancelToken cancelToken,
  );

  Future<ApiResponse> deleteNotification(int id);
  Future<int?> getNotificationCount();
}
