import 'dart:async';

import 'package:bhavani_connect/bloc_helper/bloc.dart';
import 'package:bhavani_connect/bloc_helper/bloc_provider.dart';
import 'package:flutter/material.dart';

typedef BlocListenerFunction<T extends Bloc<M>, M> = void Function(
    BuildContext context, T bloc, M state);

class BlocListener<T extends Bloc<M>, M> extends StatefulWidget {
  final Widget child;
  final T bloc;
  final BlocListenerFunction<T, M> listener;

  const BlocListener({Key key, @required this.child, this.listener, this.bloc})
      : super(key: key);

  @override
  _BlocListenerState<T, M> createState() => _BlocListenerState<T, M>();
}

class _BlocListenerState<T extends Bloc<M>, M>
    extends State<BlocListener<T, M>> {
  T _bloc;
  StreamSubscription _subscription;

  @override
  void initState() {
    _bloc = widget.bloc ?? BlocProvider.of<T>(context);
    assert(
        _bloc != null && _bloc is T, "Bloc must be of type ${T.runtimeType}");

    _subscription = _bloc.stateStream.listen((state) {
      if (mounted) {
        assert(
            state is M, "${state.runtimeType} is not of type ${M.runtimeType}");

        widget.listener(context, _bloc, state);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
