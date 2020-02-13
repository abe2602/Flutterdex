import 'package:bloc_pattern/bloc_pattern.dart';

abstract class BaseBloc {
  void getData({List<dynamic> params});
  void loading();
}