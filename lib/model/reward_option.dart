class RewardOption {
  final String? id;
  final String? option;
  final String? description;

  RewardOption({
    this.id,
    this.option,
    this.description,
  });

  factory RewardOption.fromJson(Map<String, dynamic> json) => RewardOption(
        id: json["id"],
        option: json["option"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "option": option,
        "description": description,
      };
}
