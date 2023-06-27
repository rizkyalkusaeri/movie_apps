enum StateStatus {
  initial,
  success,
  error,
  loading,
  search,
  postSuccess,
  postError,
  destroySuccess,
  destroyError,
  authorized,
  blocked,
}

extension StateStatusX on StateStatus {
  bool get isInitial => this == StateStatus.initial;
  bool get isSuccess => this == StateStatus.success;
  bool get isError => this == StateStatus.error;
  bool get isSearch => this == StateStatus.search;
  bool get isLoading => this == StateStatus.loading;
  bool get isPostSuccess => this == StateStatus.postSuccess;
  bool get isPostError => this == StateStatus.postError;
  bool get isDestroySuccess => this == StateStatus.destroySuccess;
  bool get isDestroyError => this == StateStatus.destroyError;
  bool get isAuthorized => this == StateStatus.authorized;
  bool get isBlocked => this == StateStatus.blocked;
}
