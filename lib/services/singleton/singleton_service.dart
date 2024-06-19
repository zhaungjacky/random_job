import 'package:get_it/get_it.dart';
import 'package:random_job/screens/auth/bloc/auth_bloc.dart';
import 'package:random_job/services/auth/repository/auth_repository.dart';
import 'package:random_job/services/auth/dataSources/auth_datasource_repository.dart';
import 'package:random_job/services/auth/usecases/auth_usecase_impl.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository_impl.dart';
import 'package:random_job/services/services.dart';
import 'package:random_job/services/theme/theme_provider.dart';

GetIt singleton = GetIt.instance;

Future<void> initSingleTon() async {
  singleton.registerFactory<SharedModel>(
    () => SharedModel(),
  );

  //init theme service and bloc
  _initTheme();
  //init auth service and bloc
  _initAuth();

  // chat_users
  _initUsers();
  //init accounting service and bloc
  _initAccouting();

  //init accounting_category service
  //!not bloc it required category value;
  _initAccountingCategory();

  //init todo server and bloc
  _initTodo();

//! init chat datasource and repository not bloc it required chatRoomId, is's dynamic
  _initChat();
}

_initChat() {
//! init chat datasource and repository not bloc it required chatRoomId, is's dynamic
  singleton.registerFactory<ChatDatasource>(
    () => ChatDatasourceImpl(),
  );
  singleton.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(
      singleton<ChatDatasource>(),
    ),
  );
}

_initUsers() {
  singleton.registerFactory<UserDatasource>(
    () => UserDatasourceImpl(),
  );
  singleton.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      singleton<UserDatasource>(),
    ),
  );
  singleton.registerLazySingleton<UserChatBloc>(
    () => UserChatBloc(
      singleton<UserRepository>(),
    ),
  );
}

_initTodo() {
  singleton.registerFactory<TodoDatasource>(
    () => TodoDatasourceImpl(),
  );
  singleton.registerFactory<TodoRepository>(
    () => TodoRepositoryImpl(
      singleton<TodoDatasource>(),
    ),
  );
  singleton.registerLazySingleton<TodoBloc>(
    () => TodoBloc(
      singleton<TodoRepository>(),
    ),
  );
}

_initAccountingCategory() {
  singleton.registerFactory<AccountingCategoryDatasource>(
    () => AccountingCategoryDatasourceImpl(),
  );
  singleton.registerFactory<AccountingCategoryRepository>(
    () => AccountingCategoryRepositoryImpl(
      singleton<AccountingCategoryDatasource>(),
    ),
  );
}

_initTheme() {
  singleton.registerFactory<Themes>(
    () => ThemeService(),
  );
  singleton.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc(
      singleton<Themes>(),
    ),
  );
}

_initAccouting() {
  // singleton.registerFactory<Accounting>(
  //   () => AccountingService(),
  // );
  singleton.registerFactory<AccountingDataSource>(
    () => AccountingDataSourceImpl(),
  );
  singleton.registerFactory<AccountingRepository>(
    () => AccountingRepositoryImpl(
      singleton<AccountingDataSource>(),
    ),
  );
  singleton.registerLazySingleton<AccountingBloc>(
    () => AccountingBloc(
      singleton<AccountingRepository>(),
    ),
  );
}

_initAuth() {
  //data from firebase
  singleton.registerFactory<AuthDataSourceRepository>(
    () => AuthDatasourceRepositoryImpl(),
  );
  singleton.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      singleton<AuthDataSourceRepository>(),
    ),
  );

  singleton.registerFactory<AuthUseCase>(
    () => AuthUsecaseImpl(
      singleton<AuthRepository>(),
    ),
  );

  singleton.registerLazySingleton<AuthBloc>(
    () => AuthBloc(),
  );
}
