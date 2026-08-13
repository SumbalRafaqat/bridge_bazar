/// PromoBannerModel: Home screen ke top wali "Flat 20% Off" jaisi
/// promo banner ka data (Figma: "Section - Promo Banner Carousel").
class PromoBannerModel {
  final String id;
  final String badgeText;   // "LIMITED TIME"
  final String titleLine1;  // "Flat 20% Off on"
  final String titleLine2;  // "Groceries"

  const PromoBannerModel({
    required this.id,
    required this.badgeText,
    required this.titleLine1,
    required this.titleLine2,
  });
}
