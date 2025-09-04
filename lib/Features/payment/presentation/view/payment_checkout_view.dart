import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_payment_intent_request.dart';
import 'package:payment_gateway_testing/Features/payment/presentation/manager/payment_checkout/payment_checkout_cubit.dart';
import 'package:payment_gateway_testing/core/constants/api_keys.dart';

class PaymentCheckoutView extends StatelessWidget {
  const PaymentCheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PaymentCheckoutCubit, PaymentCheckoutState>(
        listener: (context, state) {
          if (state is PaymentCheckoutFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
          if (state is PaymentCheckoutSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Success')));
          }
        },
        builder: (context, state) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<PaymentCheckoutCubit>(context).makePayment(
                  request: CreatePaymentIntentRequest(
                    amount: '200',
                    currency: 'usd',
                    customerId: APIKeys.customerId,
                  ),
                );
              },
              child: const Text('strip'),
            ),
          );
        },
      ),
    );
  }
}
