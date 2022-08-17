import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('앱으로 N각형 그리기'),
            bottom: const TabBar(
              tabs: [
                Tab(text: '앱 개발환경 세팅'),
                Tab(text: '위젯 만들기'),
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            const Center(
                child: Text(
              'Hello Everex',
              style: TextStyle(fontSize: 30, color: Colors.black),
            )),
            Input(),
          ]),
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final mycontroller = TextEditingController();

  Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('N을 입력해주세요.'),
      TextField(
        //숫자만 입력 받을것이다
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
        controller: mycontroller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          int num;
          //텍스트 값이 들어 있다면
          if (mycontroller.text.isNotEmpty) {
            num = int.parse(mycontroller.text);
            if (3 <= num && num <= 100) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Polygon(number: mycontroller.text)),
              );
            } else {
              //이곳에 안내창으 띄울생각
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('알림'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        content: const Text(
                            '다각형을 그릴 때는 3~100까지의 수 중에서 하나를 골라 입력 해주세요.'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cencel');
                              },
                              child: const Text('ok'))
                        ],
                      ));
            }
          } else {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('안내'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      content: const Text(
                          '값이 입력 되지않았습니다. 입력란에 그리고 싶은 다각형의 숫자를 입력해주세요'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Cencel');
                            },
                            child: const Text('ok'))
                      ],
                    ));
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        child: const Text(
          '확인',
          style: TextStyle(fontSize: 20, color: Color(0xff2f4550)),
        ),
      )
    ]);
  }
}

class Polygon extends StatefulWidget {
  String number = '';

  Polygon({Key? key, required this.number}) : super(key: key);

  @override
  State<Polygon> createState() => _PolygonState();
}

class _PolygonState extends State<Polygon> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: const Text('결과 화면'), automaticallyImplyLeading: true),
          body: Center(
            child: Expanded(
                child: CustomPaint(
              painter: PolygonPainter(int.parse(widget.number)),
            )),
          ),
        ));
  }
}

class PolygonPainter extends CustomPainter {
  final int n;

  PolygonPainter(this.n);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    var sizes = 100, xcenter = center.dx, ycenter = center.dy;
    for (var i = 0; i <= n; i += 1) {
      if (i == 0) {
        path.moveTo(xcenter + sizes * math.cos(i * 2 * math.pi / n),
            ycenter + sizes * math.sin(i * 2 * math.pi / n));
      } else {
        path.lineTo(xcenter + sizes * math.cos(i * 2 * math.pi / n),
            ycenter + sizes * math.sin(i * 2 * math.pi / n));
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
