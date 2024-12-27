
import 'dart:convert';

// Model classes
List<TestModelList> testModelListFromJson(String str) =>
    List<TestModelList>.from(json.decode(str).map((x) => TestModelList.fromJson(x)));

String testModelListToJson(List<TestModelList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class TestModelList {
  String savol;
  List<Variant> variant;

  TestModelList({
    required this.savol,
    required this.variant,
  });

  factory TestModelList.fromJson(Map<String, dynamic> json) {
    var variantsFromJson = json['variant'] as List;
    List<Variant> variantList =
        variantsFromJson.map((i) => Variant.fromJson(i)).toList();

    return TestModelList(
      savol: json['savol'] as String,
      variant: variantList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'savol': savol,
      'variant': variant.map((v) => v.toJson()).toList(),
    };
  }
}

class Variant {
  String key;
  String text;
  bool javob;

  Variant({
    required this.key,
    required this.text,
    required this.javob,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    // Handle cases where key is part of the variant key like 'A', 'B', 'C'
    String key = json.keys.firstWhere((k) => k != 'javob');
    return Variant(
      key: key,
      text: json[key] as String,
      javob: json['javob'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      key: text,
      'javob': javob,
    };
  }
}

