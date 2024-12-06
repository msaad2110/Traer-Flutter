import 'package:floor/floor.dart';
import 'package:traer/localdb/payment_model.dart';

@dao
abstract class PaymentDao {

  @Query('SELECT * FROM PaymentModel')
  Future<List<PaymentModel>> findAll();

  @Query('SELECT * FROM PaymentModel WHERE id = :id')
  Stream<PaymentModel?> findById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertData(PaymentModel payment);

  @Query("DELETE FROM PaymentModel")
  Future<void> deleteAll();
}