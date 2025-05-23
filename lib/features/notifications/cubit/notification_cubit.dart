import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore.tm/app/setup.dart';
import 'package:bookstore.tm/data/local/secured_storage.dart';
import 'package:bookstore.tm/features/notifications/cubit/notification_state.dart';
import 'package:bookstore.tm/models/notifications/notification_model.dart';
import 'package:bookstore.tm/repositories/notifications/notifications_repo.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/enums.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(
          NotificationState(),
        );
  final _repo = getIt<NotificationsRepo>();

  Future<void> getNotifications() async {
    if (LocalStorage.getToken == null) {
      return emit(
        NotificationState(
          apiState: APIState.error,
        ),
      );
    }
    emit(
      NotificationState(
        apiState: APIState.loading,
      ),
    );
    final response = await _repo.getNotificationsList(CancelToken());
    if (response.success) {
      final newState = NotificationState(
        apiState: APIState.success,
        currentPage: response.data['notifications'][APIKeys.pagination]
            ['current_page'],
        newNotificationsCount: 0,
        notifications: List<NotificationModel>.from(
          (response.data['notifications']['data'] as List<dynamic>).map(
            (item) => NotificationModel.fromJson(
              item,
            ),
          ),
        ),
      );
      emit(newState);
      return;
    }
    emit(
      NotificationState(
        apiState: APIState.error,
      ),
    );
  }

  Future<void> getNotificationsCount() async {
    if (LocalStorage.getToken == null) {
      return emit(
        NotificationState(
          apiState: APIState.error,
        ),
      );
    }
    emit(
      NotificationState(
        apiState: APIState.loading,
      ),
    );
    final response = await _repo.getNotificationCount();
    if (response != null) {
      final newState = NotificationState(
        apiState: APIState.success,
        currentPage: state.currentPage,
        newNotificationsCount: response,
        notifications: state.notifications,
      );
      emit(newState);
      return;
    }
    emit(
      NotificationState(
        apiState: APIState.error,
      ),
    );
  }

  Future<void> deleteNotification(int id) async {
    final response = await _repo.deleteNotification(id);
    if (response.success) {
      final newState = NotificationState(
        apiState: APIState.success,
        currentPage: state.currentPage,
        newNotificationsCount: state.newNotificationsCount,
        notifications: List<NotificationModel>.from(
          (response.data['notifications']['data'] as List<dynamic>).map(
            (item) => NotificationModel.fromJson(
              item,
            ),
          ),
        ),
      );
      emit(newState);
      return;
    }
    emit(
      NotificationState(
        apiState: APIState.error,
      ),
    );
  }
}
