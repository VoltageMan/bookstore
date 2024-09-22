import 'dart:async';
import 'package:bookstore/models/api/response_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ChatRepo {
  Future<ApiResponse> getMessagesList(int page);
  Future<ApiResponse> sendMessage(
      {String? message, XFile? file, required String type});
}
