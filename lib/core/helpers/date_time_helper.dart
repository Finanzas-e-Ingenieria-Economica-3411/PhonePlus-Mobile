String normalizeDate(String date){
  DateTime dateFetched = DateTime.parse(date);
  String dateNormalized = dateFetched.day.toString() + "/" + dateFetched.month.toString() +  "/" + dateFetched.year.toString();
  return dateNormalized;
}