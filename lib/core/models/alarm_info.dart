// ignore_for_file: prefer_const_constructors

part of 'models.dart';

class AlarmInfo {
  AlarmInfo({
    required this.rmik,
    required this.name,
    required this.born,
    required this.bed,
    required this.infus,
    required this.volume,
    required this.dose,
    required this.installed,
    required this.release,
    required this.selisih,
    required this.history,
  });
  late final String rmik;
  late final String name;
  late final DateTime born;
  late final String bed;
  late final String infus;
  late final int volume;
  late final String dose;
  late final DateTime installed;
  late final DateTime release;
  late final Duration selisih;
  late final List<History> history;

  AlarmInfo.fromJson(Map<String, dynamic> json) {
    rmik = json['rmik'] ?? '';
    name = json['name'];
    bed = json['bed'] ?? '';
    born = DateTime.parse(json['born']);
    infus = json['infus'];
    volume = int.parse(json['volume'].toString());
    dose = json['dose'];
    installed = DateTime.parse(json['installed']);
    release = DateTime.parse(json['release']);
    selisih = release.difference(installed);
    history =
        List.from(json['history']).map((e) => History.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rmik'] = rmik;
    _data['name'] = name;
    _data['born'] = born.toIso8601String();
    _data['bed'] = bed;
    _data['infus'] = infus;
    _data['volume'] = volume;
    _data['dose'] = dose;
    _data['installed'] = installed.toIso8601String();
    _data['release'] = release.toIso8601String();
    _data['history'] = history.map((e) => e.toJson()).toList();
    return _data;
  }

  int getTotalVolume() {
    int total = 0;
    history.forEach((e) {
      total = total + e.volume;
    });
    return total;
  }

  static Map<String, dynamic> toMap(AlarmInfo e) => {
        'rmik': e.rmik,
        'bed': e.bed,
        'born': e.born.toIso8601String(),
        'name': e.name,
        'infus': e.infus,
        'volume': e.volume,
        'dose': e.dose,
        'installed': e.installed.toIso8601String(),
        'release': e.release.toIso8601String(),
        'history': e.history.map((x) => x.toJson()).toList()
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

class History {
  History({
    required this.rmik,
    required this.name,
    required this.born,
    required this.bed,
    required this.infus,
    required this.volume,
    required this.dose,
    required this.installed,
    required this.release,
  });
  late final String rmik;
  late final String name;
  late final DateTime born;
  late final String bed;
  late final String infus;
  late final int volume;
  late final String dose;
  late final DateTime installed;
  late final DateTime release;

  History.fromJson(Map<String, dynamic> json) {
    rmik = json['rmik'];
    name = json['name'];
    born = DateTime.parse(json['born']);
    bed = json['bed'] ?? '';
    infus = json['infus'];
    volume = json['volume'];
    dose = json['dose'];
    installed = DateTime.parse(json['installed']);
    release = DateTime.parse(json['release']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rmik'] = rmik;
    _data['name'] = name;
    _data['born'] = born.toIso8601String();
    _data['bed'] = bed;
    _data['infus'] = infus;
    _data['volume'] = volume;
    _data['dose'] = dose;
    _data['installed'] = installed.toIso8601String();
    _data['release'] = release.toIso8601String();
    return _data;
  }
}
