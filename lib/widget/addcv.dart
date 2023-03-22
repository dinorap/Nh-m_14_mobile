import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newcv extends StatefulWidget {
  final Function addcv;

  Newcv(this.addcv);

  @override
  State<Newcv> createState() => _NewcvState();
}

class _NewcvState extends State<Newcv> {
  final tenControl = TextEditingController();
  final motacontrol = TextEditingController();
  final ngaythangcontrol = TextEditingController();
  void submitData() {
    final enten = tenControl.text;
    final enmota = motacontrol.text;
    final enngaythang = ngaythangcontrol.text;
    if (enten.isEmpty || enmota.isEmpty || enngaythang.isEmpty) return;

    widget.addcv(
      enten,
      enmota,
      enngaythang,
    );

    Navigator.of(context).pop();
  }

  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 1000,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Tên công việc'),
              controller: tenControl,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mô tả công việc'),
              controller: motacontrol,
              onSubmitted: (_) => submitData(),
            ),
            TextField( 
              decoration:
                  InputDecoration(labelText: 'Thời hạn hoàn thành(DeadLine)'),
              controller: ngaythangcontrol,
              readOnly: true,//ko hien bàn phím
              onTap: () async {
                // Hiển thị picker ngày tháng năm khi người dùng chọn trường này
                final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2050));
                if (pickedDate != null) {
                  // Cập nhật giá trị cho trường ngày tháng năm sinh
                  setState(() {
                    ngaythangcontrol.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),
            TextButton(
              child: Text('Thêm Công việc'),
              onPressed: () {
                submitData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
