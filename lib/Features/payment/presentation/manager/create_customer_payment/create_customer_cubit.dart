import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/customer_payment_info_model/customer_payment_info_model.dart';
import 'package:payment_gateway_testing/Features/payment/domain/repos/payment_checkout_repo.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_customer_request.dart';

part 'create_customer_state.dart';

class CreateCustomerCubit extends Cubit<CreateCustomerState> {
  final PaymentCheckoutRepo paymentCheckoutRepo;

  CreateCustomerCubit(this.paymentCheckoutRepo)
    : super(CreateCustomerInitial());

  Future<void> createCustomerPayment({
    required CreateCustomerRequest request,
  }) async {
    emit(CreateCustomerLoading());
    var result = await paymentCheckoutRepo.createCustomer(request: request);
    result.fold(
      (fail) {
        emit(CreateCustomerFailure(fail.errMessage));
      },
      (success) {
        emit(CreateCustomerSuccess(success));
      },
    );
  }

  @override
  void onChange(Change<CreateCustomerState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
