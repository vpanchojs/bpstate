import 'package:bpstate/src/service_locator.dart';
import 'package:flutter/material.dart';
import 'bloc_base.dart';
abstract class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key? key,
    required this.child,
    required this.blocBuilder,
    this.blocDispose,
  }) : super(key: key);

  final Widget child;
  final T Function() blocBuilder;
  final void Function(T)? blocDispose;

  @override
  State<BlocProvider<T>> createState() => BlocProviderState<T>();

  static T of<T>(BuildContext context) {
    final _BlocProviderInherited<T>? provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>?;

    if (provider == null) {
      throw FlutterError(
          'BlocProvider.of() called with a context that does not contain a Bloc of type $T.');
    }
    return provider.bloc;
  }
}

class BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  late T bloc;
  late ServiceLocator serviceLocator;

  @override
  void initState() {
    super.initState();
    bloc = widget.blocBuilder();
    bloc.translate = serviceLocator.translate;
    bloc.navigator = serviceLocator.navigator;
  }

  @override
  void dispose() {
    if (widget.blocDispose != null) {
      widget.blocDispose!(bloc);
    }
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  const _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited<T> oldWidget) =>
      oldWidget != bloc;
}
