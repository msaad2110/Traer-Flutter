

class Documents{
  int? _id;
  String? _name;

  Documents(this._id, this._name);

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}