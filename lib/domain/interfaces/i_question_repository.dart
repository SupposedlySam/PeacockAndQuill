import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

abstract class IQuestionRepository {
  final String collectionName = "questions";

  Future<List<IQuestionEntity>> getAllQuestions();
  Future<List<IQuestionEntity>> getQuestionsBySlide(int slide);
  Stream<List<IQuestionEntity>> getQuestionsByUser();
  Future<bool> hasQuestion(int pageIndex, int paragraphIndex);
  void addQuestion(String uid, int screen, int paragraph);
  void removeQuestion(int screen, int paragraph);
}
