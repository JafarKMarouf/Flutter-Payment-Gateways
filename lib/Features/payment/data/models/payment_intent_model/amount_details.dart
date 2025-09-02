import 'package:payment_gateway_testing/Features/payment/data/models/payment_intent_model/tip.dart';

class AmountDetails {
  Tip? tip;

  AmountDetails({this.tip});

  factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
    tip: json['tip'] == null
        ? null
        : Tip.fromJson(json['tip'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'tip': tip?.toJson()};
}
