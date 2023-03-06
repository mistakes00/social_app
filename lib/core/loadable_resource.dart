// import 'package:equatable/equatable.dart';

// class LoadableResource<T> extends Equatable {
//   final String? message;
//   final T data;
//   final LoadableStatus status;

//   bool get isLoading => status == LoadableStatus.loading;
//   bool get hasData => status == LoadableStatus.data;
//   bool get hasError => status == LoadableStatus.error;

//   const LoadableResource({
//     required this.data,
//     this.status = LoadableStatus.data,
//     this.message,
//   });

//   LoadableResource<T> withData(T data) => copyWith(
//         status: LoadableStatus.data,
//         data: data,
//       );

//   LoadableResource<T> withError([String? message, T? data]) => copyWith(
//         status: LoadableStatus.error,
//         message: () => message,
//         data: data ?? this.data,
//       );

//   LoadableResource<T> loading([T? data]) => copyWith(
//         status: LoadableStatus.loading,
//         data: data ?? this.data,
//       );

//   LoadableResource<T> copyWith({
//     T? data,
//     LoadableStatus? status,
//     String? Function()? message,
//     String? next,
//     String? previous,
//     int? count,
//   }) {
//     return LoadableResource<T>(
//       message: message != null ? message() : this.message,
//       data: data ?? this.data,
//       status: status ?? this.status,
//     );
//   }

//   TResult when<TResult>({
//     required TResult loading,
//     required TResult Function(T data) data,
//     required TResult error,
//   }) =>
//       isLoading
//           ? loading
//           : hasData && this.data != null
//               ? data(this.data)
//               : error;

//   TResult maybeWhen<TResult>({
//     TResult? loading,
//     TResult? data,
//     TResult? error,
//     required TResult Function() orElse,
//   }) {
//     if (isLoading && loading != null) return loading;
//     if (hasData && data != null) return data;
//     if (hasError && error != null) return error;

//     return orElse();
//   }

//   T call() => data;

//   @override
//   List<Object?> get props => [data, status, message];
// }

// enum LoadableStatus { data, error, loading }
