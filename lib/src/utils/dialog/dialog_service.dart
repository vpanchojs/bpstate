import 'dart:async';

class DialogService {
  final Map<Enum, Future<dynamic> Function(dynamic)> _dialogs = {};
  late Completer<dynamic>? _dialogCompleter;
  late Function closeDialog;
  late Function(String) showProgess;
  late Set<Enum> openDialogs = <Enum>{};

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(
      Enum key, Future<dynamic> Function(dynamic) dialog) {
    _dialogs[key] = dialog;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<T> showDialog<T>(Enum key, dynamic information) {
    if (_dialogs.containsKey(key)) {
      _dialogCompleter = Completer<T>();
      _dialogs[key]!(information);
      openDialogs.add(key);
      return _dialogCompleter!.future as Future<T>;
    }
    return Future.value();
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete([dynamic value]) {
    _dialogCompleter?.complete(value);
    _dialogCompleter = null;
    openDialogs.clear();
  }
}
