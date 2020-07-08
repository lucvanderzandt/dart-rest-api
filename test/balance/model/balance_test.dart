import 'dart:io';

import 'package:test/test.dart';

import 'package:messagebird/balance.dart';

void main() {
  group('Balance', () {
    test('should deserialize from json', () {
      final Balance balance = Balance.fromJson(
          File('test_resources/balance.json').readAsStringSync());

      expect(balance.amount, equals(10.00));
      expect(balance.type, equals('euros'));
      expect(balance.payment, Payment.prepaid);
    });
  });
}
