import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_app/data/repositories/auth_repo.dart';

part '../sign_in_cubit.freezed.dart';

enum SignInStatus {
  pure,
  loading,
  success,
  error;

  bool get isPure => this == pure;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isError => this == error;
}

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required AuthRepo userRepo})
      : _userRepo = userRepo,
        super(const SignInState());

  final AuthRepo _userRepo;

  void signIn(String email, String password) async {
    emit(state.copyWith(status: SignInStatus.loading));
    final response = await _userRepo.login(email, password);

    if (response.isSuccessful) {
      emit(state.copyWith(
        status: SignInStatus.success,
      ));
    } else {
      String? error;
      String? passwordError;
      String? emailError;

      if (response.errorData != null && response.errorData is Map) {
        final errorData = response.errorData as Map;
        if (errorData['detail'] != null) {
          error = errorData['detail'];
        }
        if (errorData['message'] != null) {
          error = errorData['message'];
        }
        if (errorData['password'] != null) {
          passwordError =
              errorData['password'].map((element) => element).join('\n');
        }
        if (errorData['email'] != null) {
          emailError = errorData['email'].map((element) => element).join('\n');
        }
      }
      emit(state.copyWith(error: error, status: SignInStatus.error));
    }
  }
}

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    String? error,
    @Default(SignInStatus.pure) final SignInStatus status,
    final String? email,
    final String? password,
  }) = _SignInState;
}
