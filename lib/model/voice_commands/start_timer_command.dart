import 'package:voice_recipe/model/voice_commands/command.dart';

class StartTimerCommand implements Command {
  static const _words = ["старт", "таймер", "пуск", "начать"];
  final void Function() onTriggerFunction;

  StartTimerCommand({required this.onTriggerFunction});

  @override
  List<String> getTriggerWords() {
    return _words;
  }

  @override
  void Function() onTrigger() {
    return onTriggerFunction;
  }
}
