import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '1% Better',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '1% Better'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num _baseline = 0;
  num _frequency = 1;
  num _result = 0;

  void _setBaseline(String s) {
    setState(() {
      _baseline = num.parse(s);
    });
    _computeResult();
  }

  void _setFrequency(num value) {
    setState(() {
      _frequency = value;
    });
    _computeResult();
  }

  void _computeResult() {
    num qty = 1 / _frequency;
    setState(() {
      _result = _baseline * (1 + qty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Baseline'),
                    keyboardType: TextInputType.number,
                    onChanged: (String s) {
                      _setBaseline(s);
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: InputDecorator(
                    decoration: InputDecoration(labelText: 'Frequency'),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _frequency,
                        items: [
                          DropdownMenuItem(
                            child: Text('Daily'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('Weekly'),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text('Monthly (30 days)'),
                            value: 30,
                          ),
                        ],
                        onChanged: (num? v) {
                          _setFrequency(v!);
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  '${_result.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
