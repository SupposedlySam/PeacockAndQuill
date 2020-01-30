import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

abstract class IQuestionUseCase {
  void addQuestion(int screen, int paragraph);

  Future<List<IQuestionEntity>> getAllQuestions();

  Future<List<IQuestionEntity>> getQuestions(int slide);

  Stream<List<IQuestionEntity>> getQuestionsByUser();

  Future<bool> hasQuestion(int pageIndex, int paragraphIndex);

  void removeQuestion(int screen, int paragraph);
}
