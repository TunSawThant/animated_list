import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedlistEg extends StatefulWidget {
  @override
  _AnimatedlistEgState createState() => _AnimatedlistEgState();
}

class _AnimatedlistEgState extends State<AnimatedlistEg> {
  final GlobalKey<AnimatedListState> _listkey=new GlobalKey();

   List<String> _data=[
   WordPair.random().toString(),
   WordPair.random().toString(),
   WordPair.random().toString(),
   WordPair.random().toString(),
   WordPair.random().toString(),
   ];

   void _addItem(){
     _data.insert(0, prefix0.WordPair.random().toString());
     _listkey.currentState.insertItem(0);
   }
  void _removeLastItem(){
    String itemToRemove=_data[0].toString();
    _listkey.currentState.removeItem(0,
        (BuildContext context,Animation<double> animation)=>_buildItem(context, itemToRemove, animation),
        duration: const Duration(milliseconds: 200));
    _data.removeAt(0);
  }
  void _removeAllitem(){
     int itemCount=_data.length;
     for(int i=0;i<itemCount;i++){
       String _itemToRem=_data[i].toString();
       _listkey.currentState.removeItem(0,
           (BuildContext context,Animation<double> animation)=>_buildItem(context, _itemToRem, animation),
         duration: const Duration(milliseconds: 200)
       ) ;
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated List",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.black),),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      persistentFooterButtons: <Widget>[
       Padding(
         padding: const EdgeInsets.only(right:85.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           mainAxisSize:MainAxisSize.max ,
           children: <Widget>[
             IconButton(icon: Icon(FontAwesomeIcons.folderPlus,color: Colors.blue,),iconSize: 45, onPressed: _addItem,),
             IconButton(icon: Icon(FontAwesomeIcons.folderMinus,color: Colors.blue,),iconSize: 45, onPressed: _removeLastItem) ,
             IconButton(icon: Icon(FontAwesomeIcons.trashAlt,color: Colors.blue,), iconSize: 45,onPressed: _removeAllitem) ,
           ],
         ),
       ),
      ],
      body: AnimatedList(
        key:_listkey ,
        initialItemCount: _data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index,animation)=>_buildItem(context, _data[index], animation),

      ),
    );
  }


  Widget _buildItem(BuildContext context,String item,Animation<double> animation){
    return Padding(
        padding: EdgeInsets.all(20.0),
      child: SizeTransition(
          sizeFactor: animation,
        axis: Axis.vertical,
        child: Container(
          height: 45.0,
          width:double.infinity,
          child: Card(
            child: Center(child: Text(item,style: TextStyle(fontSize: 20,color: Colors.white),)),
            elevation: 18.0,
            color: Colors.green,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.3),
            ),
          ),
        ),
      ),
    );
  }


}
