class ResponseModel<T> {
  T? data;
  bool _hasError = true;
  String message;

  bool get hasError => _hasError;

  ResponseModel.complete({
    required this.data,
    this.message = '',
  }) {
    _hasError = false;
  }

  ResponseModel.withError({
    required this.message,
    this.data,
  });
}
