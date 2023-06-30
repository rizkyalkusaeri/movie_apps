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
    required int statusCode,
    required String message,
  }) {
    return SingleResponse(
      results: fromJsonModel(json),
      statusCode: statusCode,
      message: message,
    );
  }
}

// class ErrorResponse extends ApiResponse {
//   ErrorResponse({
//     super.statusCode,
//     super.message,
//   });
// }

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

class ListResponseOpt<T> extends ApiResponse {
  ListResponseOpt({
    super.statusCode,
    super.message,
    super.success,
    this.results,
  });

  final List<T>? results;

  factory ListResponseOpt.fromJson({
    required Map<String, dynamic> json,
    required String key,
    required T Function(Map<String, dynamic>) fromJsonModel,
  }) {
    fromJsonList(List list) {
      return list.map((e) => fromJsonModel(e)).toList();
    }

    return ListResponseOpt(
      statusCode: json['status_code'],
      message: json['status_message'],
      success: json['success'],
      results: json[key] != null ? fromJsonList(json[key]) : [],
    );
  }
}
