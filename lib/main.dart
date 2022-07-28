import 'package:flutter/material.dart';
import 'package:homework1/shapemaker.dart';

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
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('다각형 그리기'),
            bottom: const TabBar(tabs: [
              Tab(text: '앱 개발환경 세팅'),
              Tab(text: '입력값'),
              Tab(text: 'N각형')
            ],
            ),
          ),
          body: TabBarView(
              children: <Widget>[
                 const Center(
                    child: Text(
                      'Hello Everex',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black
                      ),
                    )
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('N을 입력해주세요.'),
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      //패치로 인해 2년전과 버튼 스타일 선언이 바뀜
                      ElevatedButton(
                        onPressed:null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        child: const Text(
                          '확인',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff2f4550)
                          ),
                        ),
                      )
                    ]
                ),
                const paintShape(),
              ]
          ),
        ),
      ),
    );
  }
}
