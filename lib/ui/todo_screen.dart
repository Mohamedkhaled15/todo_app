import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/to do_item.dart';
import '../utils/database_client.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _textFieldController=new TextEditingController();
  var db=DatabaseHelper();
  final List<TodoItem>_itemsList=<TodoItem>[];

  @override
  void initState() {
    super.initState();
    _readTodoList();
//
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.green ,
      body: Column(
        children: [
          Flexible(
              child:ListView.builder(
                itemCount: _itemsList.length,
                  itemBuilder: (_,int index){
                  return Card(
                    color: Colors.orange,
                    child: ListTile(
                      title: _itemsList[index],
                      onLongPress:()=> print("long press"),
                      trailing:
                      Listener(
                        key: Key(_itemsList[index].itemName),
                        child:Icon(Icons.remove_circle,color:Colors.redAccent ,) ,
                        onPointerDown: (pointerEvent)=>_handleDelete(_itemsList[index].id,index),
                      ),
                    ),
                  );
                  }) ),
          Divider(
            height: 1.0,
          )
        ],
      ),
      floatingActionButton:FloatingActionButton(onPressed: _showFormDialog,
        backgroundColor: Colors.blue,
        child: const ListTile(
          title: Icon(Icons.add),
        ),
      ),
    );
  }
  void _showFormDialog() {
    var alert=AlertDialog(
      content:Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: _textFieldController,
            autofocus: true,
            maxLength: 25,
            decoration: const InputDecoration(
                labelText: "Item",
                hintText: "e.g buy breads",
                icon: Icon(Icons.add_alert)
            ),
          ))
        ],
      ) ,
      actions: [
        TextButton(onPressed: (){
          _handleSubmit(_textFieldController.text);
          _textFieldController.clear();
          Navigator.pop(context);
        }, child: Text("save")),
        TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("Cancel"))
      ],
    );
    showDialog(context: context, builder:(_){
      return alert;
    } );
  }



  _readTodoList()async{
    List items =await db.getAllItems();

    items.forEach((item){
     // TodoItem todoItem=TodoItem.formMap(item);
      //print("DB items =${todoItem.itemName}");
      setState(() {
        _itemsList.add(TodoItem.map(item));
      });

    });
  }
  void _handleSubmit(String text) async{
    TodoItem item=TodoItem(text, DateTime.now().toIso8601String());
    int savedItemId= await db.saveItem(item);
    TodoItem? savedItem= await db.getTodoItem(savedItemId);
    //if (kDebugMode) {
      //print("saved id =$savedItemId and saved item = ${savedItem!.itemName} ");
    //}
    setState(() {
      _itemsList.insert(0, savedItem!);
    });
  }

  _handleDelete(int id, int index) async{
    await db.deleteItem(id);
    setState(() {
      _itemsList.removeAt(index);
    });

  }
}



