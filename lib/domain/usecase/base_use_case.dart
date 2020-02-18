mixin BaseUseCase<T, Params> {
  Future<T> call(Params params);
}