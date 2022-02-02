int plusSixtyMin = 0;
List<int> result = [];
// int minusOneHour = 0;

List<int> beforeFiveMin(int hour, int minute) {
  if (minute < 5) {
    plusSixtyMin = minute + 60;
    if (hour == 00) {
      hour = 23;
    } else {
      hour = hour - 1;
    }
    minute = plusSixtyMin - 5;
  } else {
    minute -= 5;
  }
  result = [];
  result.add(hour);
  result.add(minute);
  return result;
}
