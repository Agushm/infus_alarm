// ignore_for_file: prefer_const_constructors

part of 'pages.dart';

class FormAlarmPage extends StatefulWidget {
  final AlarmInfo? data;
  const FormAlarmPage({Key? key, this.data}) : super(key: key);

  @override
  _FormAlarmPageState createState() => _FormAlarmPageState();
}

class _FormAlarmPageState extends State<FormAlarmPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController noRMIKController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bornDateController = TextEditingController();
  TextEditingController infusController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController totalVolumeController = TextEditingController();
  TextEditingController fttController = TextEditingController();
  TextEditingController tpmController = TextEditingController();
  TextEditingController releaseJamController = TextEditingController();
  TextEditingController releaseMenitController = TextEditingController();

  List<History> history = [];
  DateTime selectedBornDate = DateTime.now();
  @override
  void initState() {
    totalVolumeController.text = "0";
    if (widget.data != null) {
      noRMIKController.text = widget.data!.rmik;
      nameController.text = widget.data!.name;
      infusController.text = widget.data!.infus;
      volumeController.text = widget.data!.volume.toString();
      history = widget.data!.history;
      totalVolumeController.text = widget.data!.getTotalVolume().toString();
      selectedBornDate = widget.data!.born;
      fttController.text = widget.data!.ftt.toString();
      tpmController.text = widget.data!.tpm.toString();
      count();
    }
    bornDateController
      ..text = DateFormat('dd MMMM yyyy', 'id_ID').format(selectedBornDate)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: bornDateController.text.length,
          affinity: TextAffinity.upstream));
    super.initState();
  }

  int releaseMinute = 0;

  double totalVolume = 0;
  double totalKecepatan = 0;
  double totalWaktu = 0;
  double _totalMenit = 0;
  void count() {
    double volume = double.parse(
        volumeController.text.isEmpty ? "0" : volumeController.text);

    double jam = double.parse(releaseJamController.text.isEmpty
            ? "0"
            : releaseJamController.text) *
        60;
    double menit = double.parse(releaseMenitController.text.isEmpty
        ? "0"
        : releaseMenitController.text);
    _totalMenit = jam + menit;
    double ftt =
        double.parse(fttController.text.isEmpty ? "0" : fttController.text);
    double tpm =
        double.parse(tpmController.text.isEmpty ? "0" : tpmController.text);

    totalKecepatan = (ftt * volume) / _totalMenit;
    totalWaktu = (volume * ftt) / tpm;
    totalVolume = (_totalMenit * tpm) / ftt;
    releaseMinute = totalWaktu.toInt();
    releaseJamController.text = durationGetJam(releaseMinute);
    releaseMenitController.text = durationGetMinutes(releaseMinute);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Alarm',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: TimeInHourAndMinute()),
                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: decorationForm.copyWith(labelText: 'Nama Pasien'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  controller: bornDateController,
                  decoration:
                      decorationForm.copyWith(labelText: 'Tanggal Lahir'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: noRMIKController,
                  decoration: decorationForm.copyWith(labelText: 'No RM'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: infusController,
                  decoration: decorationForm.copyWith(
                      labelText: 'Jenis dan Dosis Cairan Infus'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: volumeController,
                        decoration: decorationForm.copyWith(
                          labelText: 'Volume',
                          suffix: Text('ml'),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (value) {
                          count();
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: totalVolumeController,
                        readOnly: true,
                        onTap: () {
                          if (history.isEmpty) {
                            DialogUtils.instance.showInfo(context,
                                title: 'Riwayat Pemasangan Infus',
                                message: 'Belum ada riwayat pemasangan infus');
                          } else {
                            DialogUtils.instance.showHistoryVolume(
                              context,
                              history: history,
                            );
                          }
                        },
                        decoration: decorationForm.copyWith(
                          labelText: 'Jumlah Volume',
                          suffix: Text('ml'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: fttController,
                  decoration: decorationForm.copyWith(
                      labelText: 'Faktor Tetes', suffix: Text('gtt/ml')),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    count();
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: tpmController,
                  decoration: decorationForm.copyWith(
                      labelText: 'Kecepatan', suffix: Text('tpm')),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    count();
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: releaseJamController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: decorationForm.copyWith(labelText: 'Jam'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (value) {
                          count();
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: releaseMenitController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: decorationForm.copyWith(labelText: 'Menit'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (value) {
                          count();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Consumer<TimerProvider>(
                  builder: (context, timer, _) {
                    if (releaseMinute != 0) {
                      DateTime _release =
                          timer.date.add(Duration(minutes: releaseMinute));
                      return Row(
                        children: [
                          Text('Perikiraan Habis',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red)),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                tanggal(_release),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                DateFormat('HH:mm').format(_release),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return SizedBox(
                      width: SizeConfig.screenWidth / 2,
                    );
                  },
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: MaterialButton(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.blue,
          height: 60,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              DateTime now = DateTime.now();
              var _release = now.add(
                Duration(minutes: releaseMinute),
              );
              history.add(History(
                rmik: noRMIKController.text,
                name: nameController.text,
                born: selectedBornDate,
                infus: infusController.text,
                volume: int.parse(volumeController.text),
                ftt: int.parse(fttController.text),
                tpm: int.parse(tpmController.text),
                installed: now,
                release: _release,
              ));

              AlarmInfo newData = AlarmInfo(
                rmik: noRMIKController.text,
                name: nameController.text,
                born: selectedBornDate,
                infus: infusController.text,
                volume: int.parse(volumeController.text),
                ftt: int.parse(fttController.text),
                tpm: int.parse(tpmController.text),
                history: history,
                installed: now,
                release: _release,
                selisih: _release.difference(now),
              );

              Provider.of<MonitoringProvider>(context, listen: false)
                  .save(oldData: widget.data, newData: newData);
              Navigator.pop(context);
            }
          },
          child: Text(
            widget.data == null ? 'Tambah Alarm' : 'Reset Alarm',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedBornDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return child!;
        });

    if (newSelectedDate != null) {
      selectedBornDate = newSelectedDate;
      bornDateController
        ..text = DateFormat('dd MMMM yyyy', 'id_ID').format(selectedBornDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: bornDateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
