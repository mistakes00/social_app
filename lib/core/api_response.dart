class ApiResponse<T> {
  String? message;
  T? result;
  dynamic errorData;
  int? statusCode;

  bool get isSuccessful =>
      statusCode != null && (statusCode! >= 200 && statusCode! <= 209);

  ApiResponse({
    this.statusCode,
    this.message,
    this.result,
    this.errorData,
  });

  TResult when<TResult>({
    required TResult Function(T? result) success,
    required TResult Function(String? message, dynamic errorData) error,
  }) =>
      isSuccessful ? success(result) : error(message, errorData);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiResponse<T> &&
        other.message == message &&
        other.result == result &&
        other.errorData == errorData &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        result.hashCode ^
        errorData.hashCode ^
        statusCode.hashCode;
  }

  @override
  String toString() {
    return 'ApiResponse(message: $message, statusCode: $statusCode, result: $result, errorData: $errorData)';
  }
}
