

import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/state_response.dart';

class FilterModel{

  Countries? _filterCountry;
  Cities? _filterCity;
  States? _filterState;
  DateTime? _starDate;
  DateTime? _endDate;

  DateTime? get starDate => _starDate;

  set starDate(DateTime? value) {
    _starDate = value;
  }

  int? _luggageSpace;
  int? _commissionStatus;   // 0 means low to high and 1 means high to low
  int? _commissionStart;
  int? _commissionEnd;



  static final FilterModel _instance = FilterModel._internal();
  FilterModel._internal();

  factory FilterModel() {
    return _instance;
  }

  factory FilterModel.getInstance() {
    return _instance;
  }


  Countries? get filterCountry => _filterCountry;

  set filterCountry(Countries? value) {
    _filterCountry = value;
  }

  Countries? get destinationCountry => _filterCountry;

  set destinationCountry(Countries? value) {
    _filterCountry = value;
  }










  int? get luggageSpace => _luggageSpace;

  set luggageSpace(int? value) {
    _luggageSpace = value;
  }



  // Clear the login data
  void clearData() {
    _filterCountry= null;
    _filterCity= null;
    _filterState= null;
    _starDate= null;
    _endDate= null;
    _luggageSpace= null;
    _commissionStatus= null;
    _commissionStart= null;
    _commissionEnd= null;
  }

  int? get commissionStatus => _commissionStatus;

  set commissionStatus(int? value) {
    _commissionStatus = value;
  }

  int? get commissionStart => _commissionStart;

  set commissionStart(int? value) {
    _commissionStart = value;
  }

  int? get commissionEnd => _commissionEnd;

  set commissionEnd(int? value) {
    _commissionEnd = value;
  }

  Cities? get filterCity => _filterCity;

  set filterCity(Cities? value) {
    _filterCity = value;
  }

  States? get filterState => _filterState;

  set filterState(States? value) {
    _filterState = value;
  }



  DateTime? get endDate => _endDate;

  set endDate(DateTime? value) {
    _endDate = value;
  }
}