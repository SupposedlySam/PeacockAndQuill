import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

abstract class IQuestionUserEntity {
  String uid;
  String presentationId;
  String name;
  String questionRef;
  ISelectionEntity selection;
}
