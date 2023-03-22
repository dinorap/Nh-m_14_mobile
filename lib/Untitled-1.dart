import 'package:flutter/material.dart';
import 'model/congviec.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //thanh appbar
        appBar: AppBar(
          //màu sác của appbar
          backgroundColor: Color.fromARGB(255, 0, 195, 255),
          //căn giữa nội dung của appbar
          title: Center(
              // nội dung
              child: Text(
            "Quản Lý Công Việc",
            //màu và cỡ chữ
            style: TextStyle(fontSize: 30, color: Colors.white),
          )),
        ),
        //nút ấn thêm công việc
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Xử lý khi nút được nhấn
          },
          tooltip: 'Thêm công việc',
          //biểu tượng
          child: Icon(Icons.add),
          backgroundColor: Colors.blue, // Đặt màu cho button
        ),
        //căn giữa nút ấn
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
