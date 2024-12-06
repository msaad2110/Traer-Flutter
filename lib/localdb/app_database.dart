import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:traer/localdb/payment_dao.dart';
import 'package:traer/localdb/payment_model.dart';
part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [PaymentModel])
abstract class AppDatabase extends FloorDatabase {
  PaymentDao get personDao;
}