import 'package:get/get.dart';
import 'package:superapp/modal/all_review_modal.dart';

class AllReviewsController extends GetxController {
  final RxInt selectedFilter = 0.obs;

  final List<ReviewFilter> filters = const [
    ReviewFilter(label: 'All', stars: null),
    ReviewFilter(label: '5', stars: 5),
    ReviewFilter(label: '4', stars: 4),
    ReviewFilter(label: '3', stars: 3),
    ReviewFilter(label: '2', stars: 2),
  ];

  final RxList<AllReviewItem> allReviews = <AllReviewItem>[
    const AllReviewItem(
      initials: 'BS',
      name: 'Bimosaurus',
      role: 'Real Estate Investor',
      stars: 5,
      text:
          "I've used other kits, but this one is the best. The attention to detail and usability are truly amazing.",
    ),
    const AllReviewItem(
      initials: 'LQ',
      name: 'Lauralee Quinn',
      role: 'Real Estate Investor',
      stars: 5,
      text:
          "I've used other kits, but this one is the best. The attention to detail and usability are truly amazing.",
    ),
    const AllReviewItem(
      initials: 'BS',
      name: 'Bimosaurus',
      role: 'Real Estate Investor',
      stars: 5,
      text:
          "I've used other kits, but this one is the best. The attention to detail and usability are truly amazing.",
    ),
  ].obs;

  void onFilterTap(int index) => selectedFilter.value = index;

  List<AllReviewItem> get filteredReviews {
    final f = filters[selectedFilter.value];
    if (f.stars == null) return allReviews;
    return allReviews.where((r) => r.stars == f.stars).toList();
  }
}

class ReviewFilter {
  final String label;
  final int? stars;
  const ReviewFilter({required this.label, required this.stars});
}
