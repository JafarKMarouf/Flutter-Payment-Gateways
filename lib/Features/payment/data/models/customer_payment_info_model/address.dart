class Address {
  String? city;
  String? country;
  dynamic line1;
  dynamic line2;
  dynamic postalCode;
  dynamic state;

  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json['city'] as String?,
    country: json['country'] as String?,
    line1: json['line1'] as dynamic,
    line2: json['line2'] as dynamic,
    postalCode: json['postal_code'] as dynamic,
    state: json['state'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'city': city,
    'country': country,
    'line1': line1,
    'line2': line2,
    'postal_code': postalCode,
    'state': state,
  };
}
