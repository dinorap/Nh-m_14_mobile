import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/dscongviec.dart';
import 'widget/addcv.dart';
import 'model/congviec.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      //tắt chữ debug
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final dateFormat = DateFormat('dd/MM/yyyy');

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  List<Congviec> _filteredCongViec = [];
  final List<Congviec> danhSachCongviec = [
    Congviec(
      id: 1,
      tencv: 'Dự án C#',
      motacv: 'Hoàn thành 50%',
      deadline: dateFormat.parse('24/06/2023'),
    ),
    Congviec(
      id: 2,
      tencv: 'Dự án phàn mềm ứng dụng',
      motacv: 'Hoàn thành 70%',
      deadline: dateFormat.parse('24/02/2023'),
    ),
  ];

  @override
  void initState() {
    _filteredCongViec.addAll(danhSachCongviec);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCongViec(String query) {
    List<Congviec> filteredCongViec = [];
    filteredCongViec.addAll(danhSachCongviec);

    if (query.isNotEmpty) {
      filteredCongViec.retainWhere((congViec) =>
          congViec.tencv.toLowerCase().contains(query.toLowerCase()));
    }

    setState(() {
      _filteredCongViec.clear();
      _filteredCongViec.addAll(filteredCongViec);
    });
  }

  void addNewCongviec(String tencv, String motacv, String deadline) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final newCongviec = Congviec(
      id: danhSachCongviec.length + 1,
      tencv: tencv,
      motacv: motacv,
      deadline: dateFormat.parse(deadline),
    );
    setState(() {
      danhSachCongviec.add(newCongviec);
      _filteredCongViec.add(newCongviec);
    });
  }

  void deleteCongViec(int index) {
    setState(() {
      danhSachCongviec.removeAt(index);
      _filteredCongViec.removeAt(index);
      for (int i = index; i < danhSachCongviec.length; i++) {
        danhSachCongviec[i].id--;
      }
    });
  }

  void startAddNewCongviec(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Newcv(addNewCongviec),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      //thanh tiêu đề
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Row(
          mainAxisAlignment:
              //căn chỉnh các đối tượng
              MainAxisAlignment.spaceBetween,
          children: [
            //căn chỉnh text
            Expanded(
              child: Text(
                'Quản Lý Công Việc',
                textAlign: TextAlign.center,
              ),
            ),
            //cotainer chứa ảnh
            Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                //bo góc của ảnh
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/linh.jpg'),
              ),
            ),
          ],
        ),
      ),
      //nút drawer
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
                child: DrawerHeader(
                  child: Container(
                    child: Text(
                      'Danh sách công việc',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(400, 50)),
                ),
                child: Text("Danh sách công việc chưa đến hạn"),
                onPressed: () {
                  setState(() {
                    _filteredCongViec = danhSachCongviec
                        .where((congViec) =>
                            congViec.deadline.isAfter(DateTime.now()))
                        .toList();
                  });
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(400, 50)),
                ),
                child: Text("Danh sách công việc đã quá deadline"),
                onPressed: () {
                  setState(() {
                    _filteredCongViec = danhSachCongviec
                        .where((congViec) =>
                            congViec.deadline.isBefore(DateTime.now()))
                        .toList();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Tìm kiếm công việc",
                hintText: "Nhập từ khóa...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              onChanged: (value) {
                _filterCongViec(value);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CongViecList(_filteredCongViec, deleteCongViec),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewCongviec(context),
      ),
    );
  }
}
