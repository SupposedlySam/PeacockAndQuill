import 'package:rxdart/rxdart.dart';
import 'package:peacock_and_quill/data/repositories/interfaces/i_question_repository.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_question_entity.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/domain/use_cases/authorization.dart';

enum ActionType { add, remove, unchanged }

mixin Question {
  final IQuestionRepository questionRepository = locator<IQuestionRepository>();

  Future<List<IQuestionEntity>> getAllQuestions() {
    return questionRepository.getAllQuestions();
  }

  Future<List<IQuestionEntity>> getQuestions(int slide) {
    return questionRepository.getQuestionsBySlide(slide);
  }

  Stream<List<IQuestionEntity>> getQuestionsByUser() {
    return locator<Authorization>().userStream.switchMap(
      (user) {
        if (user != null) {
          return questionRepository.getQuestionsByUser(user.uid);
        }
        return Stream.empty();
      },
    );
  }

  void addQuestion(int screen, int paragraph) async {
    final user = await locator<Authorization>().getUser;
    if (user != null) {
      questionRepository.addQuestion(user.uid, screen, paragraph);
    }
  }

  void removeQuestion(int screen, int paragraph) async {
    final user = await locator<Authorization>().getUser;
    if (user != null) {
      questionRepository.removeQuestion(user.uid, screen, paragraph);
    }
  }
}
