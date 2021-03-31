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

class WCVImportFile {
  WCVImportFile({
    this.date,
    this.fileName,
    this.size,
    this.filePath,
    this.fileAttached,
  });

  String date; // from text file, do we need to store in DateTime object??
  String fileName;
  String size;
  String filePath;
  String fileAttached; // string or boolean??
}

class Conversation {
  Conversation({
    this.id,
    this.fileName,
    this.list,

  });

  int id; 
  String fileName;
  String list;
}