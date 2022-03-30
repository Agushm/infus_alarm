// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

part of '../widgets.dart';

class HistoryVolumeDialog extends StatelessWidget {
  final List<History>? history;
  HistoryVolumeDialog({
    Key? key,
    this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Constants.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close)),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Riwayat Pemasangan Infus",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Container(
              constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: 400,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                  itemCount: history!.length,
                  itemBuilder: (context, index) {
                    var d = history![index];
                    return Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waktu Pemasangan',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Text(
                                formatDateWithTime.format(d.installed),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waktu Habis',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Text(
                                formatDateWithTime.format(d.release),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jenis & Dosis Infus',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Text(
                                '${d.infus}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Volume',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Text(
                                '${d.volume} ml',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
          SizedBox(height: 20),
          MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Constants.primary,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tutup', style: TextStyle(color: Colors.white))),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
