/// DealModel: "Deals of the Week" section ka ek product card
/// (Figma: Deal Card 1/2 — Sindhri Mangoes, Fresh Whole Chicken).
///
/// NOTE: Yeh model blueprint mein pehle nahi tha, kyunke jab tak humne
/// asal Figma design nahi dekha tha, humein pata nahi tha ke Home
/// screen par "deal cards" bhi honge. Real Figma dekhne ke baad add
/// kiya gaya — yehi wajah hai ke architecture "living document" hoti
/// hai, design dekh kar thodi refine hoti rehti hai.
class DealModel {
  final String id;
  final String name;
  final int price;
  final int originalPrice;
  final String saveLabel; // "Save Rs. 250"

  const DealModel({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.saveLabel,
  });
}
