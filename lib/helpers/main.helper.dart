int extractAmount(String input) {
  RegExp intRegExp = RegExp(r'\b\d+\b');
  Match match = intRegExp.firstMatch(input) as Match;

  if (match != null) {
    String? ageString = match.group(0);
    int? medicineQuantity = int.tryParse(ageString as String);

    if (medicineQuantity != null) {
      return medicineQuantity;
    }
  }

  return -1;
}
