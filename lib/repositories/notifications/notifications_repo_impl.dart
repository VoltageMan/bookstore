import 'package:dio/dio.dart';
import 'package:bookstore.tm/data/remote/dio_client.dart';
import 'package:bookstore.tm/models/api/response_model.dart';
import 'package:bookstore.tm/repositories/notifications/notifications_repo.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRepo)
class NotificationsRepoImpl extends NotificationsRepo with DioClientMixin {
  @override
  Future<ApiResponse> getNotificationsList(CancelToken cancelToken) async {
    final response = await dio.get(
      endPoint: EndPoints.notificationList,
      cancelToken: cancelToken,
    );
    return response;
  }

  @override
  Future<ApiResponse> deleteNotification(
    int id,
  ) async {
    final response = await dio.post(
      endPoint: EndPoints.notificationDelete(id),
    );
    return response;
  }

  @override
  Future<int?> getNotificationCount() async {
    final response = await dio.get(
      endPoint: EndPoints.notificationCount,
    );
    if (response.success) {
      return response.data['count'];
    }
    return null;
  }
}
