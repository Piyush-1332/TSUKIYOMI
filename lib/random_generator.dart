import 'dart:math';

int getRandom() {
  Random r = new Random();
  int min = 1;
  int max = 200;
  return min + r.nextInt(max - min);
}
