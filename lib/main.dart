import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleCalc(),
    );
  }
}

class SimpleCalc extends StatefulWidget {
  @override
  _SimpleCalcState createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 24.0;
  double resultFontSize = 72.0;

  buttonPressed(String btnText) {
    setState(
      () {
        if (btnText == "AC") {
          equation = "0";
          result = "0";
        } else if (btnText == "C") {
          equation = equation.substring(0, equation.length - 1);
          if (equation == "") {
            equation = "0";
          }
        } else if (btnText == "=") {
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = "Error";
          }
        } else {
          if (equation == "0") {
            equation = btnText;
          } else {
            equation = equation + btnText;
          }
        }
      },
    );
  }

  Widget buildCalcBtn(String btnText, Color btnColor, Color textColor) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: TextButton(
        onPressed: () => buttonPressed(btnText),
        style: TextButton.styleFrom(
          backgroundColor: btnColor,
          minimumSize: Size(72, 72),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text(
          btnText,
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0XFF1D1D1D),
        elevation: 0,
      ),
      body: Container(
        color: Color(0XFF1D1D1D),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0),
              alignment: Alignment.centerRight,
              child: Text(
                equation,
                style: GoogleFonts.poppins(
                  fontSize: equationFontSize,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 16.0),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: GoogleFonts.poppins(
                  fontSize: resultFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCalcBtn(
                              'AC', Color(0XFF3D3D3D), Color(0xFF387ED1)),
                          buildCalcBtn(
                              '+/-', Color(0XFF3D3D3D), Color(0xFF387ED1)),
                          buildCalcBtn(
                              '%', Color(0XFF3D3D3D), Color(0xFF387ED1)),
                          buildCalcBtn(
                              '÷', Color(0XFF3D3D3D), Color(0XFFDC4D4D)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCalcBtn('7', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('8', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('9', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn(
                              '×', Color(0XFF3D3D3D), Color(0XFFDC4D4D)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCalcBtn('4', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('5', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('6', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn(
                              '−', Color(0XFF3D3D3D), Color(0XFFDC4D4D)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCalcBtn('1', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('2', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('3', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn(
                              '+', Color(0XFF3D3D3D), Color(0XFFDC4D4D)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildCalcBtn('C', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('0', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn(',', Color(0XFF1D1D1D), Colors.white),
                          buildCalcBtn('=', Colors.white, Color(0XFFDC4D4D)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
