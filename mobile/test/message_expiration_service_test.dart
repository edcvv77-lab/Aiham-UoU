import 'package:flutter_test/flutter_test.dart';
import 'package:nova_chat/features/chat/domain/services/message_expiration_service.dart';

void main() {
  final start = DateTime.utc(2026, 9, 1, 12);

  test('two days is the default short retention window', () {
    expect(
      MessageExpirationService.calculateExpiry(
        MessageDuration.twoDays,
        from: start,
      ),
      start.add(const Duration(days: 2)),
    );
  });

  test('all supported retention windows map to fixed day counts', () {
    expect(MessageDuration.oneWeek.days, 7);
    expect(MessageDuration.twoWeeks.days, 14);
    expect(MessageDuration.threeWeeks.days, 21);
  });
}
