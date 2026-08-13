/// StorePreviewModel: "Stores Near You" section ka ek store card
/// (Figma: FreshMart Superstore, Green Valley Grocers).
class StorePreviewModel {
  final String id;
  final String name;
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final int etaMinutes;
  final bool isFastDelivery;

  const StorePreviewModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.etaMinutes,
    required this.isFastDelivery,
  });
}
