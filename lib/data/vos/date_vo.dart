class DateVO{
  String date;
  String? dayName;
  String? days;
  bool isSelected=false;

  DateVO(this.date, this.dayName, this.days, this.isSelected);


  @override
  String toString() {
    return 'DateVO{date: $date, dayName: $dayName, days: $days, isSelected: $isSelected}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateVO &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          dayName == other.dayName &&
          days == other.days &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      date.hashCode ^ dayName.hashCode ^ days.hashCode ^ isSelected.hashCode;
}