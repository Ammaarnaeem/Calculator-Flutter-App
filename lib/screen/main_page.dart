import 'package:flutter/material.dart';
import 'package:calculator/screen/currency_converter.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/screen/bmi.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 100,
        title: const Text(
          'Calculator', // Change the title of the app bar here
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Urbanist-Bold',
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Code to display the side panel goes here
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: '',
                transitionDuration: Duration(milliseconds: 200),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 200,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Code to handle Calculator option goes here
                              print(
                                  'Calculator clicked'); // Close the side panel
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'Calculator',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist-Bold',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Code to handle BMI Calculator option goes here
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => bmi()),
                              ); // Close the side panel
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'BMI Calculator',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist-Bold',
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CurrencyConverter()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'Currency Converter',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist-Bold',
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: CalculatorWidget(),
      ),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _expression = '';
  bool _shouldClearExpression = false;

  void _onButtonPressed(String text) {
    setState(() {
      if (_shouldClearExpression) {
        _clearExpression();
        _shouldClearExpression = false;
      }

      if (_expression == '0') {
        _expression = text;
      } else if (text == '=') {
        _evaluateExpression();
      } else if (text == 'AC') {
        _clearExpression();
      } else if (text == '⌫') {
        _expression = _expression.substring(0, _expression.length - 1);
      } else if (text == '%') {
        _expression += text; // Keep the '%' sign in the expression
      } else if (text == 'x²') {
        _squareExpression();
      } else {
        _expression += text;
      }
    });
  }

  void _evaluateExpression() {
    try {
      final Parser parser = Parser();
      final Expression expression = parser.parse(_expression);
      final ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);

      if (_expression.contains('%')) {
        // If the expression contains '%', handle the percentage calculation
        String operand1 = _expression.split('%')[0];
        String operand2 = _expression.split('%')[1];
        double value1 = double.parse(operand1);
        double value2 = double.parse(operand2);
        result = value1 * (value2 / 100);
      }

      setState(() {
        _expression = result.toString();
        _shouldClearExpression =
            true; // Set the flag to clear the expression on the next button press
      });
    } catch (e) {
      print('Expression evaluation error: $e');
    }
  }

  void _squareExpression() {
    double value = double.parse(_expression);
    double result = value * value;
    setState(() {
      _expression = result.toString();
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '= $_expression',
            style: TextStyle(fontSize: 24, color: Colors.orange),
          ),
        ),
        Divider(height: 1),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          children: [
            CalculatorButton(text: '%', onPressed: () => _onButtonPressed('%')),
            CalculatorButton(
                text: 'x²', onPressed: () => _onButtonPressed('x²')),
            CalculatorButton(text: '⌫', onPressed: () => _onButtonPressed('⌫')),
            CalculatorButton(text: '-', onPressed: () => _onButtonPressed('-')),
            CalculatorButton(text: '7', onPressed: () => _onButtonPressed('7')),
            CalculatorButton(text: '8', onPressed: () => _onButtonPressed('8')),
            CalculatorButton(text: '9', onPressed: () => _onButtonPressed('9')),
            CalculatorButton(text: '÷', onPressed: () => _onButtonPressed('/')),
            CalculatorButton(text: '4', onPressed: () => _onButtonPressed('4')),
            CalculatorButton(text: '5', onPressed: () => _onButtonPressed('5')),
            CalculatorButton(text: '6', onPressed: () => _onButtonPressed('6')),
            CalculatorButton(text: '×', onPressed: () => _onButtonPressed('*')),
            CalculatorButton(text: '1', onPressed: () => _onButtonPressed('1')),
            CalculatorButton(text: '2', onPressed: () => _onButtonPressed('2')),
            CalculatorButton(text: '3', onPressed: () => _onButtonPressed('3')),
            CalculatorButton(text: '+', onPressed: () => _onButtonPressed('+')),
            CalculatorButton(text: '.', onPressed: () => _onButtonPressed('.')),
            CalculatorButton(text: '0', onPressed: () => _onButtonPressed('0')),
            CalculatorButton(
                text: 'AC', onPressed: () => _onButtonPressed('AC')),
            CalculatorButtonOrange(
                text: '=', onPressed: () => _onButtonPressed('=')),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.black,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.orange),
        ),
      ),
    );
  }
}

class CalculatorButtonOrange extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButtonOrange({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.orange,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
