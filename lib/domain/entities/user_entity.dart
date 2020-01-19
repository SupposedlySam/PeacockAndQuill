import 'package:peacock_and_quill/domain/entities/interfaces/i_user_entity.dart';

class UserEntity extends IUserEntity {
  String uid;
  String name;

  UserEntity({
    this.uid,
    this.name,
  });
}
