// ignore_for_file: prefer_const_constructors

part of 'models.dart';

class AlarmInfo {
  AlarmInfo(
      {required this.name,
      required this.bed,
      required this.infus,
      required this.volume,
      required this.dose,
      required this.installed,
      required this.release,
      required this.selisih});
  late final String name;
  late final String bed;
  late final String infus;
  late final String volume;
  late final String dose;
  late final DateTime installed;
  late final DateTime release;
  late final Duration selisih;

  AlarmInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bed = json['bed'];
    infus = json['infus'];
    volume = json['volume'];
    dose = json['dose'];
    installed = DateTime.parse(json['installed']);
    release = DateTime.parse(json['release']);
    selisih = release.difference(installed);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['bed'] = bed;
    _data['infus'] = infus;
    _data['volume'] = volume;
    _data['dose'] = dose;
    _data['installed'] = installed;
    _data['release'] = release;
    return _data;
  }

  static Map<String, dynamic> toMap(AlarmInfo e) => {
        'bed': e.bed,
        'name': e.name,
        'infus': e.infus,
        'volume': e.volume,
        'dose': e.dose,
        'installed': e.installed.toIso8601String(),
        'release': e.release.toIso8601String()
      };
}

var jsonAlarmInfo = {
  "name": "Pasien 1",
  "bed": "Mawar 1",
  "infus": "Infus X",
  "dose": "100mg",
  "installed": DateTime.now(),
  "release": DateTime.now()
};
