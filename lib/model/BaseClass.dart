class BaseClass {
  String id = '';
  String type = '';
  String date = '';
  String tag = '';
  String name = '';
  String status = '';
  String owner = '';

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'date': date,
        'tag': tag,
        'name': name,
        'status': status,
        'owner': owner,
      };

  void fromMap(Map<String, dynamic> m) {
    this.id = m.containsKey('id') ? m['id'] : '';
    this.type = m.containsKey('type') ? m['type'] : '';
    this.date = m.containsKey('date') ? m['date'] : '';
    this.tag = m.containsKey('tag') ? m['tag'] : '';
    this.name = m.containsKey('name') ? m['name'] : '';
    this.status = m.containsKey('status') ? m['status'] : '';
    this.owner = m.containsKey('owner') ? m['owner'] : '';
  }
}
