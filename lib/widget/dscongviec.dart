import 'package:b/model/congviec.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/congviec.dart';
import 'package:b/main.dart';

class CongViecList extends StatefulWidget {
  final List<Congviec> danhSachCongviec;
  final Function(int) onDelete;

  CongViecList(this.danhSachCongviec, this.onDelete);

  @override
  _CongViecListState createState() => _CongViecListState();
}

class _CongViecListState extends State<CongViecList> {
  bool isOverdue(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: SingleChildScrollView(
        child: Column(
          children: widget.danhSachCongviec.map((cv) {
            int index = widget.danhSachCongviec.indexOf(cv);
            Color tileColor =
                isOverdue(cv.deadline) ? Colors.red : Colors.white;
            return Container(
              //giãn cách giữa các công việc
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                tileColor: tileColor,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                leading: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    cv.id.toStringAsFixed(0),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Text(
                  cv.tencv,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Mô tả:' +
                      cv.motacv +
                      '\n' +
                      "Deadline: " +
                      DateFormat('dd/MM/yyyy').format(cv.deadline),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.symmetric(vertical: 6),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 18,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.onDelete(index);
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
