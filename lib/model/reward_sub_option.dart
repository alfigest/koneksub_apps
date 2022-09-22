class RewardSubOption {
  final String? id;
  final String? amount;
  final String? name;
  final int? points;

  RewardSubOption({
    this.id,
    this.amount,
    this.name,
    this.points,
  });

  factory RewardSubOption.fromJson(Map<String, dynamic> json) =>
      RewardSubOption(
        id: json["id"],
        amount: json["amount"],
        name: json["name"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "name": name,
        "points": points,
      };
}
