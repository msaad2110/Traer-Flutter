


import 'dart:io';

class UploadDocument{

  int? _documentType;
  String? _documentName;
  List<File> _documents = [];
  File?  _selfie;



  static final UploadDocument _instance = UploadDocument._internal();
  UploadDocument._internal();

  factory UploadDocument() {
    return _instance;
  }

  factory UploadDocument.getInstance() {
    return _instance;
  }

  File? get selfie => _selfie;

  set selfie(File? value) {
    _selfie = value;
  }

  List<File> get documents => _documents;

  set documents(List<File> value) {
    _documents = value;
  }

  String? get documentName => _documentName;

  set documentName(String? value) {
    _documentName = value;
  }

  int? get documentType => _documentType;

  set documentType(int? value) {
    _documentType = value;
  }

  // Clear the  data
  void clearData() {
    _documentType = null;
    _documentName= null;
    _documents= [];
    _selfie= null;

  }
}