import 'package:mobile_pos/user_models/models.dart';

abstract class BaseCheckoutRepository {
  Future<void> addCheckout(Checkout checkout);
}
