import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/paypal/amount_model/amount.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/paypal/amount_model/details.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/paypal/order_item_list_model/order_item.dart';
import 'package:payment_gateway_testing/Features/payment/data/models/paypal/order_item_list_model/order_item_list_model.dart';
import 'package:payment_gateway_testing/Features/payment/domain/requests/create_payment_intent_request.dart';
import 'package:payment_gateway_testing/Features/payment/presentation/manager/payment_checkout/payment_checkout_cubit.dart';
import 'package:payment_gateway_testing/core/constants/api_keys.dart';

class PaymentCheckoutView extends StatelessWidget {
  const PaymentCheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    var orders = [
                      OrderItemModel(
                        name: 'Apple',
                        quantity: 4,
                        price: '5',
                        currency: 'USD',
                      ),
                      OrderItemModel(
                        name: 'Pineapple',
                        quantity: 5,
                        price: '10',
                        currency: 'USD',
                      ),
                    ];

                    var subtotal = (4 * 5) + (5 * 10);

                    var amount = AmountModel(
                      currency: "USD",
                      total: subtotal.toString(),
                      details: Details(
                        subtotal: subtotal.toString(),
                        shipping: '0',
                        shippingDiscount: 0,
                      ),
                    );

                    var itemList = OrderItemListModel(items: orders);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaypalCheckoutView(
                          clientId: APIKeys.paypalClientID,
                          secretKey: APIKeys.paypalSecretKey,
                          sandboxMode: true,
                          transactions: [
                            {
                              'amount': amount.toJson(),
                              'item_list': itemList.toJson(),
                              'description':
                                  'The payment transaction description.',
                            },
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${params['message']}',
                                ),
                              ),
                            );
                          },
                          onError: (error) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error when pay with paypal $error',
                                ),
                              ),
                            );
                          },
                          onCancel: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cancel pay with paypal'),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text('pay with Paypal'),
                );
              },
            ),
            BlocConsumer<PaymentCheckoutCubit, PaymentCheckoutState>(
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
                return ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<PaymentCheckoutCubit>(context).makePayment(
                      request: CreatePaymentIntentRequest(
                        amount: '200',
                        currency: 'usd',
                        customerId: APIKeys.customerId,
                      ),
                    );
                  },
                  child: const Text('Pay with stripe'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
