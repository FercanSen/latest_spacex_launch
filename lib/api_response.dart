class ApiResponse {
  final String name;
  final String details;
  // final String patch;

  ApiResponse({
    required this.name,
    required this.details,
    // required this.patch,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      name: json["name"],
      details: json["details"],
      // patch: json["patch"],
    );
  }
}
