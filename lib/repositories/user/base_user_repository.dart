import '../../user_models/user_model.dart';
import 'package:mobile_pos/user_models/models.dart';

abstract class BaseUserRepository {
  Stream<User> getUser(String userId);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
}
