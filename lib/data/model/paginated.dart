class Paginated<T> {
  const Paginated({
    this.count,
    this.next,
    this.previous,
    required this.data,
  });

  factory Paginated.fromJson({
    required Map<String, dynamic> json,
    required T data,
  }) =>
      Paginated(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        data: data,
      );

  final int? count;
  final String? next;
  final String? previous;
  final T data;
}
