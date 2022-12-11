// Generic Interface for all BLoCs
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bloc_base.dart';
import 'utils/dialog/type_message.dart';
import 'utils/localization/app_localizations.dart';

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key? key,
    required this.child,
    required this.blocBuilder,
    this.blocDispose,
  }) : super(key: key);

  final Widget child;
  final BlocBuilder<T> blocBuilder;
  final BlocDisposer<T>? blocDispose;

  @override
  State<BlocProvider<T>> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final _BlocProviderInherited<T>? provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>?;

    return provider!.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  late T bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.blocBuilder();
    if (bloc is BlocLocal) {
      // setup dialog service
      final blocLocal = bloc as BlocLocal;
      blocLocal.dialogService.showProgess = _showProgress;
      blocLocal.dialogService.closeDialog = closeDialog;
      // setup message service
      blocLocal.messageService
          .registerComponent(component: _showMessageSnackBar);
    }
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
    if (bloc is BlocLocal) {
      final blocLocal = bloc as BlocLocal;
      blocLocal.translate = AppLocalizationsBase.of(context).translate;
      blocLocal.navigator = GoRouter.of(context);
    }    
    return _BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child,
    );
  }

  void _showMessageSnackBar(String message, TypeMessage typeMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
    ));
  }

  Future<void> _showProgress(String message) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(children: <Widget>[
                  const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )),
                  const SizedBox(width: 16),
                  Expanded(child: Text(message))
                ]),
              ),
            ),
          );
        });
  }

  void closeDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
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
