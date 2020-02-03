import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_questions_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_question_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_view_model.dart';

class BaseViewModel extends ChangeNotifier {
  final IQuestionUseCase questionUseCase;
  final KeyPressViewModel keyPressModel;
  final NavigatorState navigator;
  bool _showQuestions = false;
  bool _showHeader = true;
  List<IQuestionsEntity> _questions = [];

  BaseViewModel({
    @required this.questionUseCase,
    @required this.keyPressModel,
    @required this.navigator,
  });

  bool get showQuestions => _showQuestions;
  bool get showHeader => _showHeader;
  List<IQuestionsEntity> get questions => _questions;

  void toggleQuestions() async {
    _showQuestions = !_showQuestions;
    if (_showQuestions) {
      _questions = await questionUseCase.getAllQuestions();
      navigator.pop();
    }
    notifyListeners();
  }

  void setHeader({@required bool value}) {
    _showHeader = !value;
    notifyListeners();
  }

  void handleQuestionPressed(IQuestionsEntity questionsEntity) {
    keyPressModel.navigateToSlide(questionsEntity.screen);
    toggleQuestions();
  }
}
