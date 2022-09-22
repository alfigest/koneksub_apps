class RewardTransaction {
  final String? id;
  final String? optionId;
  final String? subOptionId;
  final String? userId;
  final int? points;
  final String? createdAt;

  RewardTransaction({
    this.id,
    this.optionId,
    this.subOptionId,
    this.userId,
    this.points,
    this.createdAt,
  });

  factory RewardTransaction.fromJson(Map<String, dynamic> json) =>
      RewardTransaction(
        id: json["id"],
        optionId: json["option_id"],
        subOptionId: json["sub_option_id"],
        userId: json["user_id"],
        points: json["points"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "option_id": optionId,
        "sub_option_id": subOptionId,
        "user_id": userId,
        "points": points,
        "created_at": createdAt,
      };
}
