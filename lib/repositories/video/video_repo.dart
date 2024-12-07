import 'package:bookstore.tm/models/api/paginated_data_model.dart';
import 'package:bookstore.tm/models/videos/video_model.dart';

abstract class VideoRepo {
  Future<PaginatedDataModel<List<HomeVideoModel>>?> getVideos(int page);
}
