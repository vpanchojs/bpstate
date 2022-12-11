import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';

import 'utils/dialog/dialog_service.dart';
import 'utils/dialog/message_service.dart';
import 'utils/dialog/type_message.dart';

typedef BlocBuilder<T> = T Function();
typedef BlocDisposer<T> = Function(T);

abstract class BlocBase {
  void dispose();
  late GoRouter navigator;
}

abstract class BlocGlobal extends BlocBase {
  final Set<BlocBase> _internalBlocs = {};

  void setNavigator(GoRouter router) {
    super.navigator = router;
  }

  T? getInternalBlocs<T extends BlocBase>() {
    return _internalBlocs.firstWhereOrNull((BlocBase element) => element is T)
        as T?;
  }

  void addInternalBloc(BlocBase bloc) {
    _internalBlocs.add(bloc);
  }

  void removeInternalBloc<T extends BlocBase>() {
    _internalBlocs.removeWhere((element) => element is T);
  }
}

abstract class BlocLocal extends BlocBase {
  DialogService dialogService = DialogService();
  late String Function(String key) translate;
  MessageService messageService = MessageService();

  void showProgressWithMessage(String message) {
    dialogService.showProgess(message);
  }

  void closeDialog() {
    dialogService.closeDialog();
  }

  void showMessage(String message, TypeMessage type) {
    messageService.showMessage(message, type);
  }
}
