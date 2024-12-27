
class ReytingModelList {
  final String image;
  final String name;
  final int ball;

  ReytingModelList({
    required this.image,
    required this.name,
    required this.ball,
  });

  factory ReytingModelList.fromJson(Map<String, dynamic> json) => ReytingModelList(
    image: json["image"],
    name: json["name"],
    ball: json["ball"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
    "ball": ball,
  };
}
