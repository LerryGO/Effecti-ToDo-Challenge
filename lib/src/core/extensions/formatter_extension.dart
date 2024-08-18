import 'package:intl/intl.dart';

extension FormatterStringExtension on String {
  String get toStringDate {
    final date = DateFormat('dd/MM/yyyy').format(DateTime.parse(this));
    return date;
  }

  String get toStringDateWithTime {
    final date = DateFormat('dd/MM/yy HH:mm').format(DateTime.parse(this));
    return date;
  }

  String get toStringDateTime {
    DateTime? date;
    final formats = [
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS"),
      DateFormat("dd-MM-yyyy"),
      DateFormat("EEE, dd MMM yyyy", "pt_BR"),
    ];

    for (var format in formats) {
      try {
        date = format.parse(replaceAll('/', '-'));
        break;
      } catch (e) {
        continue;
      }
    }

    if (date == null) {
      throw FormatException('Formato de data inválido: $this');
    }

    final newFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    return newFormat.format(date);
  }

  String get toStringCompleteDate {
    final DateFormat originalFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    final DateTime date = originalFormat.parse(this);
    final DateFormat formatter = DateFormat("EEE, dd MMM yyyy", "pt_BR");
    return formatter.format(date);
  }

  DateTime get toDateTime {
    final date = toStringDateTime;
    return DateTime.parse(date);
  }
}
