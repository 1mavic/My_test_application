import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_test_application/domain/bloc/user_bloc/user_state.dart';
import "package:flutter_test_application/domain/entity/user/user_model.dart";
import "package:flutter_test_application/domain/services/user_service.dart";

abstract class UserEvent {}

class GetUsersAndClearCache extends UserEvent {}


class GetUsersEvent extends UserEvent {}

class UserBloc extends Bloc<UserEvent, UserScreenState> {
  List<User> _users = <User>[];

  List<User> get users => _users;

  User? getUser(int id) {
    final int _findedInsex = _users.indexWhere((User user) => user.id == id);
    return _findedInsex != -1 ? _users[_findedInsex] : null;
  }

  final UserService _userService = UserService();
  UserBloc() : super(UserLoadingState()) {
    on<GetUsersEvent>(
        (GetUsersEvent event, Emitter<UserScreenState> emit) async {
      emit(UserLoadingState());
      final List<User> _usersList = await _userService.getUsers();
      if (_usersList.isEmpty) {
        emit(UserErrorState(error: "Получен пустой список пользователей"));
        return;
      }
      _users = _usersList;
      emit(UserListObtainedState());
      return;
    });
    on<GetUsersAndClearCache>(
        (GetUsersAndClearCache event, Emitter<UserScreenState> emit) async {
      emit(UserLoadingState());
      final List<User> _usersList = await _userService.getUsers(true);
      if (_usersList.isEmpty) {
        emit(UserErrorState(error: "Получен пустой список пользователей"));
        return;
      }
      _users = _usersList;
      emit(UserListObtainedState());
      return;
    });
  }
}
