enum MessageDuration {
  twoDays,
  oneWeek,
  twoWeeks,
  threeWeeks,
}

class MessageExpirationService {
  static DateTime calculateExpiry(MessageDuration duration) {
    final now = DateTime.now();

    switch (duration) {
      case MessageDuration.twoDays:
        return now.add(const Duration(days: 2));
      case MessageDuration.oneWeek:
        return now.add(const Duration(days: 7));
      case MessageDuration.twoWeeks:
        return now.add(const Duration(days: 14));
      case MessageDuration.threeWeeks:
        return now.add(const Duration(days: 21));
    }
  }
}
