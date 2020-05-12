import 'package:bhavani_connect/bloc_helper/lightweight_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef BlocBuilderFunction<T extends Bloc<dynamic>> = T Function(BuildContext);

class BlocProvider<T extends Bloc<dynamic>> extends StatefulWidget
    with SingleChildStatefulWidgetMixin {
  final Widget child;
  final BlocBuilderFunction<T> builder;
  final bool autoInit;

  BlocProvider({
    Key key,
    this.builder,
    this.child,
    this.autoInit = true,
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc<dynamic>>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } catch (_) {
      throw FlutterError(
        """
        BlocProvider.of() called with a context that does not contain a Bloc of type $T.
        The context used was: $context
        """,
      );
    }
  }

}

class _BlocProviderState<T extends Bloc<dynamic>>
    extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      child: widget.child,
      dispose: (context, bloc) {
        bloc?.dispose();
      },
      create: (BuildContext context) {
        final Bloc b = widget.builder(context);
        if (widget.autoInit) {
          b.init();
        }
        return b;
      },
    );
  }
}

class MultiBlocProvider extends StatelessWidget {
  final List<BlocProvider> blocProviders;
  final List<BlocProvider> Function(BuildContext context) builder;
  final Widget child;

  const MultiBlocProvider(
      {Key key, this.blocProviders, this.child, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(blocProviders != null || builder != null);
    return MultiProvider(
      providers: builder != null ? builder(context) : blocProviders,
      child: child,
    );
  }
}
