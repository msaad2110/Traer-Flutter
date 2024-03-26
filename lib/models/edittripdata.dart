

import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/models/all_luggagetype.dart' as luggageData;
import 'package:traer/models/trip_history_model.dart';

class EditTripData {

  int? _id;
  Countries? _destinationCountry;
  Countries? _originCountry;
  Cities? _destinationCity;
  Cities? _originCity;
  States? _destinationState;
  States? _originState;
  DateTime? _startDate;
  DateTime? _endDateDate;
  String? _luggageSpace;
  LuggageType? _luggageType;
  String? _commission;


  static final EditTripData _instance = EditTripData._internal();
  EditTripData._internal();

  factory EditTripData() {
    return _instance;
  }

  factory EditTripData.getInstance() {
    return _instance;
  }


  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  Countries? get destinationCountry => _destinationCountry;

  set destinationCountry(Countries? value) {
    _destinationCountry = value;
  }

  States? get originState => _originState;

  set originState(States? value) {
    _originState = value;
  }

  States? get destinationState => _destinationState;

  set destinationState(States? value) {
    _destinationState = value;
  }

  Cities? get originCity => _originCity;

  set originCity(Cities? value) {
    _originCity = value;
  }

  Cities? get destinationCity => _destinationCity;

  set destinationCity(Cities? value) {
    _destinationCity = value;
  }

  Countries? get originCountry => _originCountry;

  set originCountry(Countries? value) {
    _originCountry = value;
  }

  String? get commission => _commission;

  set commission(String? value) {
    _commission = value;
  }

  LuggageType? get luggageType => _luggageType;

  set luggageType(LuggageType? value) {
    _luggageType = value;
  }

  String? get luggageSpace => _luggageSpace;

  set luggageSpace(String? value) {
    _luggageSpace = value;
  }

  DateTime? get endDateDate => _endDateDate;

  set endDateDate(DateTime? value) {
    _endDateDate = value;
  }

  DateTime? get startDate => _startDate;

  set startDate(DateTime? value) {
    _startDate = value;
  }


  // Clear the login data
  void clearData() {
    _id = null;
    _destinationCountry= null;
    _originCountry= null;
    _destinationCity= null;
    _originCity= null;
    _destinationState= null;
    _originState= null;
    _startDate= null;
    _endDateDate= null;
    _luggageSpace= null;
    _luggageType= null;
    _commission= null;
  }




}