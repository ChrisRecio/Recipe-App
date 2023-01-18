// SQL
// CREATE TABLE Course(id INTEGER NOT NULL PRIMARY KEY autoincrement, course_name TEXT);
class Course {
  int _id;
  String _courseName;

  Course(this._id, this._courseName);

  factory Course.fromMap(Map<String, dynamic> data) {
    return Course(data['id'], data['courseName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'courseName': _courseName,
    };
  }

  @override
  String toString() {
    return 'recipe{id: $_id, courseName: $_courseName}';
  }
}
