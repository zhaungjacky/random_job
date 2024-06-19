import 'package:random_job/services/feathers/chat/users/datasource/user_datasource.dart';

abstract interface class UserRepository {
  Stream<List<Map<String, dynamic>>> getUsersStream();
}

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);
  @override
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return userDatasource.getUsersStream();
  }
}
