//T Navigator
abstract class ServiceLocator<T> {
  String Function(String) get translate => throw UnimplementedError('translate() has not been implemented.');
  T Function() get navigator => throw UnimplementedError('navigator() has not been implemented.');  
}