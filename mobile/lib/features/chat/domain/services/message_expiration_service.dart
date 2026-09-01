enum MessageDuration {
  twoDays,
  oneWeek,
  twoWeeks,
  threeWeeks,
}

extension MessageDurationX on MessageDuration {
  int get days => switch (this) {
        MessageDuration.twoDays => 2,
        MessageDuration.oneWeek => 7,
        MessageDuration.twoWeeks => 14,
        MessageDuration.threeWeeks => 21,
      };

  String get label => switch (this) {
        MessageDuration.twoDays => 'يومان',
        MessageDuration.oneWeek => 'أسبوع',
        MessageDuration.twoWeeks => 'أسبوعان',
        MessageDuration.threeWeeks => '3 أسابيع',
      };
}

class MessageExpirationService {
  const MessageExpirationService._();

  static DateTime calculateExpiry(
    MessageDuration duration, {
    DateTime? from,
  }) {
    final start = (from ?? DateTime.now()).toUtc();
    return start.add(Duration(days: duration.days));
  }
}
