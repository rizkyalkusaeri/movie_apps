class ApiResponse {
  final int? statusCode;
  final String? message;
  final bool? success;

  ApiResponse({
    this.statusCode,
    this.message,
    this.success,
  });
}

class SingleResponse<T> extends ApiResponse {
  SingleResponse({
    super.statusCode,
    super.message,
    super.success,
    this.results,
  });

  final T? results;

  factory SingleResponse.fromJson({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) fromJsonModel,
  }) {
    return SingleResponse(
      statusCode: json['status_code'],
      message: json['status_message'],
      success: json['success'],
      results: json['results'] != null ? fromJsonModel(json['results']) : null,
    );
  }
}

class ListResponse<T> extends ApiResponse {
  ListResponse({
    super.statusCode,
    super.message,
    super.success,
    this.results,
  });

  final List<T>? results;

  factory ListResponse.fromJson({
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) fromJsonModel,
  }) {
    fromJsonList(List list) {
      return list.map((e) => fromJsonModel(e)).toList();
    }

    return ListResponse(
      statusCode: json['status_code'],
      message: json['status_message'],
      success: json['success'],
      results: json['results'] != null ? fromJsonList(json['results']) : [],
    );
  }
}