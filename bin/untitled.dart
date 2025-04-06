/*
Дан массив/список чисел размера N. Разрешается выполнять ТОЛЬКО операции обмена
двух элементов данного массива. Найти такую последовательность обменов, которая
отсортирует числа в исходном массиве/списке. Кол-во обменов должно получиться не
более N, сложность алгоритма - O(n*log(n)).

Подсказка: составляем массив из элементов (значение, первоначальная позиция,
конечная позиция), первые два поля заполняем, сортируем по значению. Затем
заполняем конечную позицию и сортируем второй раз по начальной позиции. Получили
массив, для каждого элемента которого известно, где он должен оказаться, далее -
очевидно.
 */
import 'dart:math';

void main() {
  List<int> arr = [for (int i = 0; i < 10; i++) Random().nextInt(100)]; // Создаем массив чисел
  print("Исходный массив: $arr");
  print(sort(arr));
}

List<int> sort(List<int> arr) {
  List<Elements> helpList = []; // Создаем вспомогательный список элементов

  for (int i = 0; i < arr.length; i++) {
    helpList.add(new Elements.withoutFinal(arr[i], i));
  }

  helpList.sort((a, b) =>
  a.value - b.value,); // По факту мы говорим ЯП, по какому принципу сортировать

  for (int j = 0; j < helpList.length; j++) {
    helpList[j].finalPos = j;
  }

  helpList.sort((a, b) => a.startPos - b.startPos);

  int cnt = 0;

  for (int i = 0; i < helpList.length; i++) {
    if (helpList[i].finalPos != helpList[i].startPos) {
      Elements elt = helpList[i];
      swap(arr, elt.startPos, elt.finalPos, helpList);
      cnt++;
    }
  }

  print("Количество замен: $cnt.\nN = ${helpList.length}");
  return arr;
}

void swap(List list, int i, int j, List<Elements> helpList) {
  RangeError.checkValidIndex(i, list);
  RangeError.checkValidIndex(j, list);

  // Меняем местами элементы в массиве
  var tmp = list[i];
  list[i] = list[j];
  list[j] = tmp;

  // Обновляем startPos в helpList
  Elements elementI = helpList.firstWhere((e) => e.startPos == i); // Ищем первое совпадение, т.к. по заданию не больше 1
  Elements elementJ = helpList.firstWhere((e) => e.startPos == j);

  // Меняем startPos у элементов
  int tempStartPos = elementI.startPos;
  elementI.startPos = elementJ.startPos;
  elementJ.startPos = tempStartPos;
}


class Elements {
  int value;
  int startPos;
  late int finalPos;

  Elements(this.value, this.startPos, this.finalPos);

  Elements.withoutFinal(this.value, this.startPos){
    finalPos = -1;
  }

  String toString() {
    return "Elements{$value, $startPos, $finalPos}";
  }
}
