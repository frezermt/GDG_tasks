import 'dart:async';
import 'dart:io';

class Calculator {
  double add(double a, double b) => a + b;
  double subtract(double a, double b) => a - b;
  double multiply(double a, double b) => a * b;
  double divide(double a, double b) {
    if (b == 0) {
      throw Exception('Division by zero is not allowed');
    }
    return a / b;
  }

  double modulus(double a, double b) {
    if (b == 0) {
      throw Exception('Modulus by zero is not allowed');
    }
    return a % b;
  }

  double power(double a, double b) => pow(a, b);
}

double pow(double base, double exponent) {
  if (exponent == 0) return 1;
  if (exponent < 0) return 1 / pow(base, -exponent);
  return base * pow(base, exponent - 1);
}

Future<void> performCalculation(Calculator calculator) async {
  print('Enter the first number:');
  double? num1 = double.tryParse(stdin.readLineSync() ?? '');

  print('Enter the operator (+, -, *, /, %, ^):');
  String? operator = stdin.readLineSync();

  print('Enter the second number:');
  double? num2 = double.tryParse(stdin.readLineSync() ?? '');

  if (num1 == null || num2 == null || operator == null) {
    print('Invalid input. Please enter valid numbers and operator.');
    return;
  }

  try {
    double result;
    switch (operator) {
      case '+':
        result = calculator.add(num1, num2);
        break;
      case '-':
        result = calculator.subtract(num1, num2);
        break;
      case '*':
        result = calculator.multiply(num1, num2);
        break;
      case '/':
        result = calculator.divide(num1, num2);
        break;
      case '%':
        result = calculator.modulus(num1, num2);
        break;
      case '^':
        result = calculator.power(num1, num2);
        break;
      default:
        throw Exception('Invalid operator');
    }

    print('Calculating...');
    await Future.delayed(Duration(seconds: 5));
    print('Result: $result');
  } catch (e) {
    print('Error: ${e.toString()}');
  }
}

void main() async {
  final calculator = Calculator();

  while (true) {
    await performCalculation(calculator);

    print('\nDo you want to perform another calculation? (y/n)');
    String? answer = stdin.readLineSync()?.toLowerCase();
    if (answer != 'y') break;
  }

  print('Thank you for using the calculator!');
}
