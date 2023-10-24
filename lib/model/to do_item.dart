import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  String? _itemName;
  String? _dateCreated;
  int? _id;

  TodoItem(this._itemName, this._dateCreated, {super.key});

  TodoItem.map(dynamic obj) {
    this._itemName = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
    this._id = obj["id"];
  }

  String get itemName => _itemName!;

  String get dateCreated => _dateCreated!;

  int get id => _id!;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = _itemName;
    map["dateCreated"] = _dateCreated;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  TodoItem.formMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _itemName!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Created on $_dateCreated",
                  style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 10,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
