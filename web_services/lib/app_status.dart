enum AppStatus {loading, success, error, nome}

extension AppStatusExt on AppStatus{
  stati var _value;
  get value => _value;
  set value(value) => _value = value;
}