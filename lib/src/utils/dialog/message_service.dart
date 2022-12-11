import 'type_message.dart';

class MessageService {
  late Function(String message, TypeMessage type) componentMessage;

  void registerComponent(
      {required Function(String message, TypeMessage type) component}) {
    componentMessage = component;
  }

  void showMessage(String message, TypeMessage type) {
    componentMessage(message, type);
  }
}
