class APIKeys {
  static const String stripeSecretKey = String.fromEnvironment(
    "STRIPE_SECRET_KEY",
  );

  static const String stripePublishKey = String.fromEnvironment(
    "STRIPE_PUBLISHE_KEY",
  );

  static const String customerId = String.fromEnvironment("STRIPE_CUSTOMER_ID");

  static const String paypalClientID = String.fromEnvironment(
    "PAYPAL_CLIENT_ID",
  );

  static const String paypalSecretKey = String.fromEnvironment(
    "PAYPAL_SECRET_KEY",
  );
}
