final String tableNotes = 'notes';

//for reading database record
class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, rating, isImportant, number, title, address, description, time
  ];
  //primary key is with _
  static final String id = '_id';
  static final String rating = 'rating';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String address = 'address';
  static final String description = 'description';
  static final String time = 'time';

}
//all fields we want to store in database
class Note {
  final int? id;
  final int rating;
  final bool isImportant;
  final int number;
  final String title;
  final String address;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.rating,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.address,
    required this.description,
    required this.createdTime,
  });

  Note copy({
    int? id,
    int? rating,
    bool? isImportant,
    int? number,
    String? title,
    String? address,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id?? this.id,
        rating: rating ?? this.rating,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        address: address ?? this.address,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  //convert json object to note object
  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    rating: json[NoteFields.rating] as int,
    //compare with 1 = true, or 0 = false
    isImportant: json[NoteFields.isImportant] == 1,
    number: json[NoteFields.number] as int,
    title: json[NoteFields.title] as String,
    address: json[NoteFields.address] as String,
    description: json[NoteFields.description] as String,
    //create string object to datetime object
    createdTime: DateTime.parse(json[NoteFields.time] as String),
  );

  //convert field to json object
  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.rating: rating,
    NoteFields.title: title,
    NoteFields.address: address,
    //change boolean to number, important = 1, unimportant = 0
    NoteFields.isImportant: isImportant ? 1 : 0,
    NoteFields.number: number,
    NoteFields.description: description,
    //convert datetime object to proper string
    NoteFields.time: createdTime.toIso8601String(),
  };
}