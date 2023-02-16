extension ObjectCastX on Object {
  T? tryCast<T>() {
    if (this is T) {
      return this as T;
    } else {
      return null;
    }
  }
}
