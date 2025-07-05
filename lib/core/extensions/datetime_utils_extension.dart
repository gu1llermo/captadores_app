import 'package:intl/intl.dart';

extension DatetimeUtilsExtension on DateTime {
  String getFormat01(){
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this);
  }
}