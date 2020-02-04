import 'package:flutter/foundation.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

class QuestionEntity implements IQuestionEntity {
  String refId;
  ISelectionEntity selection;
  String presentationId;
  String uid;

  QuestionEntity({
    @required this.selection,
    @required this.presentationId,
    @required this.uid,
    @required this.refId,
  });
}
