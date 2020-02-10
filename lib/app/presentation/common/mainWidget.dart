import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:state_navigation/app/presentation/common/BaseBloc.dart';
import 'package:state_navigation/app/presentation/common/viewUtils.dart';
import 'package:state_navigation/domain/error/error.dart';

class BaseView<T>{
  AsyncSnapshot<T> snapshot;
  BaseBloc bloc;
  BaseView(this.snapshot);

  @protected
  Widget getResultWidget(Function getData){
    if (snapshot.hasData && snapshot.data != null)
      return loading();
    if (snapshot.hasData)
      return getLayout(snapshot.data);
    if (snapshot.hasError) {
      if (snapshot.error is NetworkException)
        return internetEmptyState(() {
          bloc.loading();
          getData();
        });
      else
        return Text(snapshot.error.toString());
    } else
      return loading();
  }

  getLayout(dynamic data){}
}