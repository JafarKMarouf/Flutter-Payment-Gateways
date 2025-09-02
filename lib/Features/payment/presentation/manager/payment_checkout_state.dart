part of 'payment_checkout_cubit.dart';

@immutable
sealed class PaymentCheckoutState {}

final class PaymentCheckoutInitial extends PaymentCheckoutState {}

final class PaymentCheckoutLoading extends PaymentCheckoutState {}

final class PaymentCheckoutSuccess extends PaymentCheckoutState {}

final class PaymentCheckoutFailure extends PaymentCheckoutState {
  final String errMessage;

  PaymentCheckoutFailure(this.errMessage);
}
