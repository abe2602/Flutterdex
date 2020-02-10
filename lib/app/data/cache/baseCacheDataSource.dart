import 'package:hive/hive.dart';
import 'package:state_navigation/domain/error/error.dart';

abstract class BaseCacheDataSource<T> {
  Future<Box> getHiveBox() async => await Hive.openBox(runtimeType.toString());

  List<T> readList(Box box) {
    var cachedList = box.get(runtimeType.toString())?.cast<T>();

    if (cachedList == null)
      throw CacheException();
    else
      return cachedList;
  }

  void write(Box box, {T data, List<T> list}) {
    if (list == null)
      box.put(runtimeType.toString(), T);
    else
      box.put(runtimeType.toString(), list);
  }
}
