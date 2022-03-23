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
  TextEditingController bedController = TextEditingController();
  TextEditingController infusController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController totalVolumeController = TextEditingController();
  TextEditingController doseController = TextEditingController();
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

      bedController.text = widget.data!.bed;
      infusController.text = widget.data!.infus;
      volumeController.text = widget.data!.volume.toString();
      doseController.text = widget.data!.dose;
      history = widget.data!.history;
      totalVolumeController.text = widget.data!.getTotalVolume().toString();
      selectedBornDate = widget.data!.born;
    }
    bornDateController
      ..text = DateFormat('dd MMMM yyyy', 'id_ID').format(selectedBornDate)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: bornDateController.text.length,
          affinity: TextAffinity.upstream));
    super.initState();
  }

  int releaseMinute = 0;

  void countMinute() {
    double jam = double.parse(releaseJamController.text.isEmpty
            ? "0"
            : releaseJamController.text) *
        60;
    double menit = double.parse(releaseMenitController.text.isEmpty
        ? "0"
        : releaseMenitController.text);
    releaseMinute = (jam + menit).toInt();
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
                  decoration:
                      decorationForm.copyWith(labelText: 'Jenis Cairan Infus'),
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
                        decoration:
                            decorationForm.copyWith(labelText: 'Volume'),
                        keyboardType: TextInputType.numberWithOptions(),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
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
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: doseController,
                  decoration: decorationForm.copyWith(labelText: 'Dosis'),
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
                        controller: releaseJamController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          countMinute();
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: decorationForm.copyWith(labelText: 'Jam'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: releaseMenitController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          countMinute();
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: decorationForm.copyWith(labelText: 'Menit'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
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
                bed: bedController.text,
                infus: infusController.text,
                volume: int.parse(volumeController.text),
                dose: doseController.text,
                installed: now,
                release: _release,
              ));

              AlarmInfo newData = AlarmInfo(
                rmik: noRMIKController.text,
                name: nameController.text,
                born: selectedBornDate,
                bed: bedController.text,
                infus: infusController.text,
                volume: int.parse(volumeController.text),
                history: history,
                dose: doseController.text,
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
        firstDate: DateTime(2000),
        lastDate: DateTime(2150),
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
