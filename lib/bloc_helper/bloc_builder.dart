import 'package:bhavani_connect/bloc_helper/bloc.dart';
import 'package:bhavani_connect/bloc_helper/bloc_provider.dart';
import 'package:flutter/material.dart';

typedef BlocWidgetBuilderFunction<T extends Bloc<M>, M> = Widget Function(
    BuildContext context, T bloc, M state);

class BlocWidgetBuilder<T extends Bloc<M>, M> extends StatefulWidget {
  final T bloc;
  final BlocWidgetBuilderFunction<T, M> builder;

  const BlocWidgetBuilder({Key key, @required this.builder, this.bloc})
      : super(key: key);

  @override
  _BlocWidgetBuilderState<T, M> createState() =>
      _BlocWidgetBuilderState<T, M>();
}

class _BlocWidgetBuilderState<T extends Bloc<M>, M>
    extends State<BlocWidgetBuilder<T, M>> {
  T _bloc;

  @override
  void initState() {
    _bloc = widget.bloc ?? BlocProvider.of<T>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<M>(
      stream: _bloc.stateStream,
      initialData: _bloc.latestState,
      builder: (context, snapshot) {
        return widget.builder(context, _bloc, snapshot.data);
      },
    );
  }
}
