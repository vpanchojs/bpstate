import 'package:bpstate/bpstate.dart';
import 'package:flutter/material.dart';

class MyBlocProvider<T extends BlocBase> extends BlocProvider<T> {
  const MyBlocProvider({
    Key? key,
    required Widget child,
    required T Function() blocBuilder,
    void Function(T)? blocDispose,
  }) : super(
          key: key,
          child: child,
          blocBuilder: blocBuilder,
          blocDispose: blocDispose,
        );

  @override
  State<BlocProvider<T>> createState() => _MyBlocProviderState<T>();
}

class _MyBlocProviderState<T extends BlocBase> extends BlocProviderState<T> {
  @override
  void initState() {
    // Lógica personalizada para la inicialización del BLoC
    super.initState();
  }

  @override
  void dispose() {
    // Lógica personalizada para la disposición del BLoC
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }
}
