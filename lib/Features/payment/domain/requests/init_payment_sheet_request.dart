class InitPaymentSheetRequest {
  final String displayName;
  final String paymentIntentClientSecret;
  final String? customerEphemeralKeySecret;
  final String? customerId;

  const InitPaymentSheetRequest({
    required this.displayName,
    required this.paymentIntentClientSecret,
    this.customerEphemeralKeySecret,
    this.customerId,
  });
}
