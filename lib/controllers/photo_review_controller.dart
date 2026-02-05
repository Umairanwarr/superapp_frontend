import 'package:get/get.dart';
import 'package:superapp/modal/photo_review_modal.dart';

class PhotoReviewController extends GetxController {
  final RxList<PhotoReviewItem> items = <PhotoReviewItem>[].obs;

  int get pendingCount => items.where((e) => e.pending).length;

  @override
  void onInit() {
    super.onInit();
    _seed();
  }

  void openItem(PhotoReviewItem item) {
    //Get.to(() => PhotoReviewDetailScreen(item: item));
  }

  void _seed() {
    items.assignAll(const [
      PhotoReviewItem(
        id: '1',
        title: 'Unit 4B  -  Leak',
        status: 'Fixed',
        albumLine: 'Before & After',
        photos: 2,
        metaLine: 'Site: Mike R  •  1h ago',
        pending: true,
      ),
      PhotoReviewItem(
        id: '2',
        title: 'Unit 12A  -  HVAC',
        status: 'install',
        albumLine: 'Completion',
        photos: 3,
        metaLine: 'Site: Sarah S  •  3h ago',
        pending: true,
      ),
      PhotoReviewItem(
        id: '3',
        title: 'Unit 7C  -  Move-in',
        status: 'Inspection',
        albumLine: '',
        photos: 8,
        metaLine: 'Agent: Tom K  •  1d ago',
        pending: true,
      ),
    ]);
  }
}
