import 'package:intl/intl.dart';

final formatDateWithTime = DateFormat('dd/MM/yyyy HH:mm');
final formatDate = DateFormat('dd/MM/yyyy HH:mm');
String tanggal(DateTime date) {
  return "${_day(date.weekday)}, ${date.day} ${_convertToLocalMonth(date.month, false)} ${date.year}";
}

String _day(int weekday) {
  switch (weekday) {
    case 1:
      return "Senin";
    case 2:
      return "Selasa";
    case 3:
      return "Rabu";
    case 4:
      return "Kamis";
    case 5:
      return "Jum'at";
    case 6:
      return "Sabtu";
    case 7:
      return "Minggu";
    default:
      return "";
  }
}

List _longMonth = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];
List _shortMonth = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des'
];

String _convertToLocalMonth(int month, bool shortMonth) {
  if (shortMonth) return _shortMonth[month - 1];
  return _longMonth[month - 1];
}

String formatJamAndMinute(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')} Jam ${parts[1].padLeft(2, '0')} Menit';
}

final formatter = NumberFormat("#,##0", "in_ID");
String formatInt(int nominal) {
  return formatter.format(nominal);
}