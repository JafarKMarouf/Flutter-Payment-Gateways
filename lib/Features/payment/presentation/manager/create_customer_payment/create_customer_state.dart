part of 'create_customer_cubit.dart';

sealed class CreateCustomerState {}

final class CreateCustomerInitial extends CreateCustomerState {}

final class CreateCustomerLoading extends CreateCustomerState {}

final class CreateCustomerSuccess extends CreateCustomerState {
  final CustomerPaymentInfoModel customer;

  CreateCustomerSuccess(this.customer);
}

final class CreateCustomerFailure extends CreateCustomerState {
  final String errMessage;

  CreateCustomerFailure(this.errMessage);
}
