// ignore_for_file: prefer_const_constructors

part of 'pages.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController volumeController = TextEditingController();
  TextEditingController waktuJamController = TextEditingController();
  TextEditingController waktuMenitController = TextEditingController();
  TextEditingController fttController = TextEditingController();
  TextEditingController tpmController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penghitungan Cairan Infus',
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
              children: [
                TextFormField(
                  controller: volumeController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: decorationForm.copyWith(
                    labelText: 'Volume',
                    suffix: Text('ml'),
                  ),
                  onChanged: (value) {
                    count();
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: waktuJamController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: decorationForm.copyWith(
                            labelText: 'Waktu (jam)', suffix: Text('jam')),
                        onChanged: (value) {
                          count();
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: waktuMenitController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: decorationForm.copyWith(
                            labelText: 'Waktu (menit)', suffix: Text('menit')),
                        onChanged: (value) {
                          count();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: fttController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: decorationForm.copyWith(
                      labelText: 'Faktor Tetes', suffix: Text('gtt/ml')),
                  onChanged: (value) {
                    count();
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: tpmController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: decorationForm.copyWith(
                      labelText: 'Kecepatan', suffix: Text('tpm')),
                  onChanged: (value) {
                    count();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Builder(
                  builder: (context) {
                    if (volumeController.text.isNotEmpty &&
                        _totalMenit != 0 &&
                        fttController.text.isNotEmpty) {
                      return Row(
                        children: [
                          Text(
                            'Kecepatan Infus',
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            '${totalKecepatan.toStringAsFixed(2)} tpm',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
                Builder(
                  builder: (context) {
                    if (volumeController.text.isNotEmpty &&
                        tpmController.text.isNotEmpty &&
                        fttController.text.isNotEmpty) {
                      return Row(
                        children: [
                          Text(
                            'Waktu',
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            formatJamAndMinute(totalWaktu.toInt()),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
                Builder(
                  builder: (context) {
                    if (_totalMenit != 0 &&
                        tpmController.text.isNotEmpty &&
                        fttController.text.isNotEmpty) {
                      return Row(
                        children: [
                          Text(
                            'Volume',
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          Text(
                            '${totalVolume.toStringAsFixed(2)} ml',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue),
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double totalVolume = 0;
  double totalKecepatan = 0;
  double totalWaktu = 0;
  double _totalMenit = 0;
  void count() {
    double volume = double.parse(
        volumeController.text.isEmpty ? "0" : volumeController.text);

    double jam = double.parse(
            waktuJamController.text.isEmpty ? "0" : waktuJamController.text) *
        60;
    double menit = double.parse(
        waktuMenitController.text.isEmpty ? "0" : waktuMenitController.text);
    _totalMenit = jam + menit;
    double ftt =
        double.parse(fttController.text.isEmpty ? "0" : fttController.text);
    double tpm =
        double.parse(tpmController.text.isEmpty ? "0" : tpmController.text);

    totalKecepatan = (ftt * volume) / _totalMenit;
    totalWaktu = (volume * ftt) / tpm;
    totalVolume = (_totalMenit * tpm) / ftt;
    setState(() {});
  }
}
