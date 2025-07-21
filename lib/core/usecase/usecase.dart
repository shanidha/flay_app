abstract class UseCase<Type,Params> {
  //Type is return type of method,
  Future<Type> call({Params params});
}
