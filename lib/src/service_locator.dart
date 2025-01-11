//T Navigator
abstract class ServiceLocator<T> {
  String Function(String) get translate;
  T Function() get navigator;  
}