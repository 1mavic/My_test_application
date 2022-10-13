import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_app/domain/bloc/user_bloc/user_state.dart";
import "package:my_app/domain/entity/user/user_model.dart";
import "package:my_app/domain/services/user_service.dart";

abstract class UserEvent {}

class GetUsersAndClearCache extends UserEvent {}

class GetUsersEvent extends UserEvent {}

class UserBloc extends Bloc<UserEvent, UserScreenState> {
  List<User> _users = <User>[];

  List<User> get users => _users;

  User? getUser(int id) {
    final int findedInsex = _users.indexWhere((User user) => user.id == id);
    return findedInsex != -1 ? _users[findedInsex] : null;
  }

  final UserService _userService;
  UserBloc(this._userService) : super(UserLoadingState()) {
    on<GetUsersEvent>(
        (GetUsersEvent event, Emitter<UserScreenState> emit) async {
      emit(UserLoadingState());
      final List<User> usersList = await _userService.getUsers();
      if (usersList.isEmpty) {
        emit(UserErrorState(error: "Получен пустой список пользователей"));
        return;
      }
      _users = usersList;
      emit(UserListObtainedState());
      return;
    });
    on<GetUsersAndClearCache>(
        (GetUsersAndClearCache event, Emitter<UserScreenState> emit) async {
      emit(UserLoadingState());
      final List<User> usersList =
          await _userService.getUsers(clearCache: true);
      if (usersList.isEmpty) {
        emit(UserErrorState(error: "Получен пустой список пользователей"));
        return;
      }
      _users = usersList;
      emit(UserListObtainedState());
      return;
    });
  }
}
