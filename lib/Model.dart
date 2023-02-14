import 'dart:core';

class Currency {
  final dynamic usd;
  final dynamic inr;
  final dynamic aud;
  final dynamic cad;

  Currency(
      {required this.usd,
      required this.inr,
      required this.aud,
      required this.cad});

  factory Currency.fromJson({required Map json}) {
    return Currency(
        usd: json['conversion_rates']['USD'],
        inr: json['conversion_rates']['INR'],
        aud: json['conversion_rates']['AUD'],
        cad: json['conversion_rates']['CAD']);
  }
}
