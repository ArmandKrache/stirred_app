String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final timeDifference = now.difference(dateTime);

  if (timeDifference.inDays < 4) {
    if (timeDifference.inHours < 24) {
      final hours = timeDifference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else {
      final days = timeDifference.inDays;
      if (days == 1) {
        return "Yesterday";
      }
      return '$days days ago';
    }
  } else {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }
}



