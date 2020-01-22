import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/domain/use_cases/question.dart';

class QuestionViewModel with Question {
  var _tapPosition;

  Future<ActionType> showCustomMenu(
    BuildContext context,
    int pageIndex,
    int paragraphIndex,
  ) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    final hasQuestion = await showMenu(
      context: context,
      items: <PopupMenuEntry<bool>>[_QuestionBarEntry()],
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
    );

    final userTappedOff = hasQuestion == null;
    if (userTappedOff) return ActionType.unchanged;

    if (hasQuestion) {
      super.addQuestion(pageIndex, paragraphIndex);
    } else {
      super.removeQuestion(pageIndex, paragraphIndex);
    }

    return hasQuestion ? ActionType.add : ActionType.remove;
  }

  void storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  Stream<List<IQuestionEntity>> getQuestionsByUser() {
    return super.getQuestionsByUser();
  }
}

class _QuestionBarEntry extends PopupMenuEntry<bool> {
  @override
  final double height = 80;

  @override
  bool represents(bool n) => n == true || n == false;

  @override
  QuestionBarEntryState createState() => QuestionBarEntryState();
}

class QuestionBarEntryState extends State<_QuestionBarEntry> {
  void _markWithQuestion() {
    Navigator.pop<bool>(context, true);
  }

  void _removeQuestion() {
    Navigator.pop<bool>(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: _markWithQuestion,
            child: Text("?", style: TextStyle(fontSize: 25)),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: _removeQuestion,
            child: Text('X', style: TextStyle(fontSize: 25)),
          ),
        ),
      ],
    );
  }
}
