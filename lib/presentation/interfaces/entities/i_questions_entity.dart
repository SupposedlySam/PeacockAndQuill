import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

abstract class IQuestionsEntity {
  int screen;
  List<IQuestionEntity> questions;
}
