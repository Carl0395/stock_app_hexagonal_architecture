import 'dart:math';

String generateRandomNumber({int length = 13}) {
  final Random random = Random();
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < length; i++) {
    buffer.write(random.nextInt(10)); // Agrega un dígito aleatorio (0-9)
  }

  return buffer.toString();
}
