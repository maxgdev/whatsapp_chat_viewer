class Chat {
  Chat({
    this.date,
    this.time,
    this.name,
    this.message,
    this.fileAttached,
  });

  String date; // from text file, do we need to store in DateTime object??
  String time; // from text file, do we need to store in DateTime object??
  String name;
  String message;
  String fileAttached; // string or boolean??
}
