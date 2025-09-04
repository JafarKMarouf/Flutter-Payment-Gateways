class CreateCustomerRequest {
  final String name;
  final String email;
  final Address? address;

  const CreateCustomerRequest({
    required this.name,
    required this.email,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'address': address!.toJson()};
  }
}

class Address {
  final String? city;
  final String? country;

  const Address({this.city, this.country});

  Map<String, dynamic> toJson() => {'city': city, 'country': country};
}
