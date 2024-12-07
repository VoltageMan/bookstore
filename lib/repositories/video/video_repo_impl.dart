import 'package:bookstore.tm/data/remote/dio_client.dart';
import 'package:bookstore.tm/models/api/paginated_data_model.dart';
import 'package:bookstore.tm/models/pagination/pagination_model.dart';
import 'package:bookstore.tm/models/videos/video_model.dart';
import 'package:bookstore.tm/repositories/video/video_repo.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VideoRepo)
class VideoRepoImpl with DioClientMixin implements VideoRepo {
  @override
  Future<PaginatedDataModel<List<HomeVideoModel>>?> getVideos(int page) async {
    final response = await dio
        .get(endPoint: EndPoints.videoList, queryParameters: {'page': page});

    if (response.success) {
      final data = response.data[APIKeys.videos] as Map<String, dynamic>;
      final videoJsonList = data[APIKeys.data] as List;
      final videos = videoJsonList
          .map((e) => HomeVideoModel.fromMap(e as Map<String, dynamic>))
          .toList();
      final pagination = PaginationModel.fromJson(data[APIKeys.pagination]);

      return PaginatedDataModel(data: videos, pagination: pagination);
    }

    return null;
  }
}
