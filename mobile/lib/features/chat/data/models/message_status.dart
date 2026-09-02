enum MessageStatus {
  sending,
  sent,
  delivered,
  read;

  String get label {
    switch (this) {
      case MessageStatus.sending:
        return 'جاري الإرسال';
      case MessageStatus.sent:
        return 'تم الإرسال';
      case MessageStatus.delivered:
        return 'تم الوصول';
      case MessageStatus.read:
        return 'تمت القراءة';
    }
  }
}
