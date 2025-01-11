import 'utils/dialog/dialog_service.dart';

typedef BlocBuilder<T> = T Function();
typedef BlocDisposer<T> = Function(T);

//T navigator
abstract class BlocBase<T> {
  void dispose();
  late T navigator;
  DialogService dialogService = DialogService();
  late String Function(String key) translate;

  void setNavigator(T router) {
    navigator = router;
  }
}
