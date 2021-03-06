import 'package:peacock_and_quill/presentation/interfaces/entities/i_user_entity.dart';

class UserEntity implements IUserEntity {
  String uid;
  String name;
  String activePresentation;

  UserEntity({
    this.uid,
    this.name,
    this.activePresentation,
  });
}
