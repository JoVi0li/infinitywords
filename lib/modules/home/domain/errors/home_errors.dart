abstract class HomeError {
  final String code;
  final String message;
  final String error;

  HomeError({
    required this.code,
    required this.message,
    required this.error,
  });
}

class GenericHomeError extends HomeError {
  GenericHomeError({
    required super.message,
    required super.error,
  }) : super(code: 'unknow');
}
