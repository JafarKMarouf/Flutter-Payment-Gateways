class CreatePaymentIntentRequest {
  final String amount;
  final String currency;

  const CreatePaymentIntentRequest({
    required this.amount,
    required this.currency,
  });
}
