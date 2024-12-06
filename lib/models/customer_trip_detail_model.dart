

class  CustomerTripDetailModel {
  int? _id;
  int? _luggage_type_id;
  String? _travelling_from;
  String? _travelling_to;
  String? _start_date;
  String? _end_date;
  String? _start_time;
  String? _end_time;
  String? _luggage_space;
  int? _commission;
  int? _created_by_id;
  int? _updated_by_id;
  String? _created_at;
  String? _updated_at;
  String? _deleted_by_id;
  String? _deleted_at;
  LuggageType? _luggage_type;
  CreatedBy? _created_by;


  CustomerTripDetailModel(
      this._id,
      this._luggage_type_id,
      this._travelling_from,
      this._travelling_to,
      this._start_date,
      this._end_date,
      this._start_time,
      this._end_time,
      this._luggage_space,
      this._commission,
      this._created_by_id,
      this._updated_by_id,
      this._created_at,
      this._updated_at,
      this._deleted_by_id,
      this._deleted_at,
      this._luggage_type,
      this._created_by);

  String? get start_time => _start_time;

  set start_time(String? value) {
    _start_time = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  int? get luggage_type_id => _luggage_type_id;

  LuggageType? get luggage_type => _luggage_type;

  set luggage_type(LuggageType? value) {
    _luggage_type = value;
  }

  String? get deleted_at => _deleted_at;

  set deleted_at(String? value) {
    _deleted_at = value;
  }

  String? get deleted_by_id => _deleted_by_id;

  set deleted_by_id(String? value) {
    _deleted_by_id = value;
  }

  String? get updated_at => _updated_at;

  set updated_at(String? value) {
    _updated_at = value;
  }

  String? get created_at => _created_at;

  set created_at(String? value) {
    _created_at = value;
  }

  int? get updated_by_id => _updated_by_id;

  set updated_by_id(int? value) {
    _updated_by_id = value;
  }

  int? get created_by_id => _created_by_id;

  set created_by_id(int? value) {
    _created_by_id = value;
  }

  int? get commission => _commission;

  set commission(int? value) {
    _commission = value;
  }

  String? get luggage_space => _luggage_space;

  set luggage_space(String? value) {
    _luggage_space = value;
  }

  String? get end_date => _end_date;

  set end_date(String? value) {
    _end_date = value;
  }

  String? get start_date => _start_date;

  set start_date(String? value) {
    _start_date = value;
  }

  String? get travelling_to => _travelling_to;

  set travelling_to(String? value) {
    _travelling_to = value;
  }

  String? get travelling_from => _travelling_from;

  set travelling_from(String? value) {
    _travelling_from = value;
  }

  set luggage_type_id(int? value) {
    _luggage_type_id = value;
  }

  CreatedBy? get created_by => _created_by;

  set created_by(CreatedBy? value) {
    _created_by = value;
  }

  String? get end_time => _end_time;

  set end_time(String? value) {
    _end_time = value;
  }


}

class LuggageType {
  int? _id;
  String? _name;

  LuggageType(this._id, this._name);

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}



class CreatedBy {
  int? _id;
  String? _first_name;
  String? _last_name;
  String? _email;
  String? _phone;
  String? _country;
  int? _is_traveller;
  int? _is_verified;
  String? _stripe_id;
  String? _pm_type;
  String? _pm_last_four;
  ProfilePicture? _profile_picture;


  CreatedBy(
      this._id,
      this._first_name,
      this._last_name,
      this._email,
      this._phone,
      this._country,
      this._is_traveller,
      this._is_verified,
      this._stripe_id,
      this._pm_type,
      this._pm_last_four,
      this._profile_picture);

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  String? get first_name => _first_name;

  set first_name(String? value) {
    _first_name = value;
  }

  String? get last_name => _last_name;

  set last_name(String? value) {
    _last_name = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
  }

  String? get country => _country;

  set country(String? value) {
    _country = value;
  }

  int? get is_traveller => _is_traveller;

  set is_traveller(int? value) {
    _is_traveller = value;
  }

  int? get is_verified => _is_verified;

  set is_verified(int? value) {
    _is_verified = value;
  }

  String? get stripe_id => _stripe_id;

  set stripe_id(String? value) {
    _stripe_id = value;
  }

  String? get pm_type => _pm_type;

  set pm_type(String? value) {
    _pm_type = value;
  }

  String? get pm_last_four => _pm_last_four;

  set pm_last_four(String? value) {
    _pm_last_four = value;
  }

  ProfilePicture? get profile_picture => _profile_picture;

  set profile_picture(ProfilePicture? value) {
    _profile_picture = value;
  }
}

class ProfilePicture {
  int? _id;
  int? _document_type_id;
  int? _user_id;
  String? _name;
  String? _file_name;
  String? _file_path;
  String? _file_preview_path;

  ProfilePicture(this._id, this._document_type_id, this._user_id, this._name,
      this._file_name, this._file_path, this._file_preview_path);

  String? get file_preview_path => _file_preview_path;

  set file_preview_path(String? value) {
    _file_preview_path = value;
  }

  String? get file_path => _file_path;

  set file_path(String? value) {
    _file_path = value;
  }

  String? get file_name => _file_name;

  set file_name(String? value) {
    _file_name = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  int? get user_id => _user_id;

  set user_id(int? value) {
    _user_id = value;
  }

  int? get document_type_id => _document_type_id;

  set document_type_id(int? value) {
    _document_type_id = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}