class APIEndPoints {
  static const String paymentUrl = 'https://api.stripe.com/v1';
  static const String createCustomerPayment = '$paymentUrl/customers';
  static const String createPaymentIntent = '$paymentUrl/payment_intents';

  static const String createEphemeralKeys = '$paymentUrl/ephemeral_keys';
}
