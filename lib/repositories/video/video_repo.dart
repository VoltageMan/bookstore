import 'package:bookstore/models/api/paginated_data_model.dart';
import 'package:bookstore/models/videos/video_model.dart';

abstract class VideoRepo {
  Future<PaginatedDataModel<List<HomeVideoModel>>?> getVideos(int page);
}
