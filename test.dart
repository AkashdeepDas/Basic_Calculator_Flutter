import 'package:math_expressions/math_expressions.dart';

void main() {
  Parser p = new Parser();
  Expression exp = p.parse("(123+456)/3");
  var result = exp.evaluate(EvaluationType.REAL,
      null); // if context is not available replace it with null.
  print(result.runtimeType);
}
