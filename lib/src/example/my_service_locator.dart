import '../../bpstate.dart';

class MyServiceLocator extends ServiceLocator {
  MyServiceLocator._internal();

  static final MyServiceLocator instance = MyServiceLocator._internal();

  @override
  Function() get navigator => () {};

  @override
  String Function(String p1) get translate => (value) {
        return '';
      };
}
