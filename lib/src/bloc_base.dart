import 'utils/dialog/dialog_service.dart';
import 'utils/toast/toast_service.dart';

typedef BlocBuilder<T> = T Function();
typedef BlocDisposer<T> = Function(T);

//T navigator
abstract class BlocBase<T> {
  void dispose();
  late T navigator;
  DialogService dialogService = DialogService();
  ToastService toastService =  ToastService();
  late String Function(String key) translate;
}
