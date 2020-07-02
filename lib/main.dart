import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String inputExpression = "";
  String result = "";
  Parser p = Parser();

  void onTap(String symbol) {
    setState(() {
      if (symbol == '=') {
        try {
          Expression exp = p.parse(inputExpression);
          result = exp.evaluate(EvaluationType.REAL, null).toStringAsFixed(2);
        } catch (e) {
          inputExpression = "";
          result = "Invalid";
        }
      } else if (symbol == 'C') {
        inputExpression = "";
        result = "";
      } else if (symbol == 'Del') {
        try {
          inputExpression =
              inputExpression.substring(0, inputExpression.length - 1);
        } catch (e) {}
      } else {
        inputExpression = inputExpression + symbol;
      }
    });
  }

  Widget buildButton(String selectedSymbol,
      {Color buttonColor = kDefaultButtonColor}) {
    return GestureDetector(
      onTap: () => onTap(selectedSymbol),
      child: Container(
        width: kButtonWidth,
        height: kButtonHeight,
        alignment: Alignment.center,
        child: Text(
          selectedSymbol,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: buttonColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      alignment: Alignment.topRight,
                      child: Text(
                        inputExpression,
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 60.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildButton('C'),
                          buildButton('('),
                          buildButton(')'),
                          buildButton(
                            'Del',
                            buttonColor: kButtonOperationColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildButton('7'),
                          buildButton('8'),
                          buildButton('9'),
                          buildButton(
                            '/',
                            buttonColor: kButtonOperationColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildButton('4'),
                          buildButton('5'),
                          buildButton('6'),
                          buildButton(
                            '*',
                            buttonColor: kButtonOperationColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildButton('1'),
                          buildButton('2'),
                          buildButton('3'),
                          buildButton(
                            '-',
                            buttonColor: kButtonOperationColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildButton('0'),
                          buildButton('.'),
                          buildButton(
                            '=',
                            buttonColor: kEqualsButtonColor,
                          ),
                          buildButton(
                            '+',
                            buttonColor: kButtonOperationColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
