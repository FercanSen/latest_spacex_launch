import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toString());

class ApiResponse {
  final String name;
  final String details;

  ApiResponse({
    required this.name,
    required this.details,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      name: json["name"],
      details: json["details"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "details": details,
      };
}

class Links {
  Patch patch;
  String webcast;

  Links({
    required this.patch,
    required this.webcast,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        patch: Patch.fromJson(json["patch"]),
        webcast: json["webcast"],
      );

  Map<String, dynamic> toJson() => {
        "patch": patch.toJson(),
        "webcast": webcast,
      };
}

class Patch {
  String small;
  String large;

  Patch({
    required this.small,
    required this.large,
  });

  factory Patch.fromJson(Map<String, dynamic> json) => Patch(
        small: json["small"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
      };
}
