import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway_testing/Features/payment/data/repos/payment_checkout_repo_impl.dart';
import 'package:payment_gateway_testing/Features/payment/presentation/manager/payment_checkout/payment_checkout_cubit.dart';
import 'package:payment_gateway_testing/Features/payment/presentation/view/payment_checkout_view.dart';
import 'package:payment_gateway_testing/core/constants/api_keys.dart';

void main() async {
  Stripe.publishableKey = APIKeys.stripePublishKey;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PaymentCheckoutCubit(PaymentCheckoutRepoImpl()),
        child: PaymentCheckoutView(),
      ),
    );
  }
}
