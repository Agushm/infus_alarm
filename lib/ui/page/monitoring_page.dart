// ignore_for_file: prefer_const_constructors,
// ignore: prefer_const_literals_to_create_immutables
part of 'pages.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({Key? key}) : super(key: key);

  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monitoring Pemberian Cairan Infus Pasien',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer<MonitoringProvider>(
        builder: (context, prov, _) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: commonTable(
                columns: [
                  DataColumn(
                    label: Center(
                      child: Text(
                        "No",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "Nama Pasien",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "No RM",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "Tanggal Lahir",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "Jenis dan Dosis Cairan Infus",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "Volume",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "Waktu Pasang",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "Waktu Habis",
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text(
                        "Opsi",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
                rows: prov.pasien.map((data) {
                  var lastPasien = prov.lastPasien();
                  int index = prov.pasien.indexOf(data);
                  return DataRow(
                      color: lastPasien == data
                          ? MaterialStateColor.resolveWith(
                              (states) => Color(0xffC70039))
                          : MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => FormAlarmPage(data: data)));
                      },
                      cells: [
                        DataCell(
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                                color: lastPasien == data
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        DataCell(
                          Text(data.name,
                              style: TextStyle(
                                  color: lastPasien == data
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        DataCell(
                          Text(data.rmik,
                              style: TextStyle(
                                  color: lastPasien == data
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        DataCell(
                          Text(
                              DateFormat('dd MMMM yyyy', 'id_ID')
                                  .format(data.born),
                              style: TextStyle(
                                  color: lastPasien == data
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        DataCell(
                          Text(data.infus,
                              style: TextStyle(
                                  color: lastPasien == data
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        DataCell(
                          Text(formatInt(data.volume),
                              style: TextStyle(
                                  color: lastPasien == data
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        DataCell(
                          Text(formatDate.format(data.installed),
                              style: TextStyle(
                                  color: lastPasien == data
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        DataCell(
                          Text(formatDate.format(data.release),
                              style: TextStyle(
                                  color: lastPasien == data
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        DataCell(
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  var confirm = await DialogUtils.instance
                                      .showConfirmDialog(
                                          context,
                                          'Hapus Kategori',
                                          'Anda yakin ingin menghapus data ini?');
                                  if (confirm!) {
                                    prov.delete(data);
                                  }
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.close,
                                        color: Colors.red, size: 12),
                                    SizedBox(width: 5),
                                    Text(
                                      'Hapus',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ]);
                }).toList(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormAlarmPage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
