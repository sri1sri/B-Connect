
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDateRow({DateTime timestamp}) => dMyyyyhmFormatDate(timestamp: timestamp);

String yyyyMdhmFormatDate({DateTime timestamp}){
  DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm");
  return timestamp != null ? dateFormat.format(timestamp) : '-';
}

String dMyyyyhmFormatDate({DateTime timestamp}){
  DateFormat dateFormat = DateFormat("dd-MM-yyy hh:mm");
  return timestamp != null ? dateFormat.format(timestamp) : '-';
}

String yyyyMdFormatDate({DateTime timestamp}){
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return timestamp != null ? dateFormat.format(timestamp) : '-';
}

String dMyyyyFormatDate({DateTime timestamp}){
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  return timestamp != null ? dateFormat.format(timestamp) : '-';
}

String hhmmFormatDate({DateTime timestamp}){
  DateFormat dateFormat = DateFormat("hh:mm a");
  return timestamp != null ? dateFormat.format(timestamp) : '-';
}