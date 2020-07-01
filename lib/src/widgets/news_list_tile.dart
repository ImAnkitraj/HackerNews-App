import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import 'package:sqflite/sqflite.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_container.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget{
  final int itemId;
  NewsListTile({this.itemId});
  Widget build(context){
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context,AsyncSnapshot<Map<int ,Future<ItemModel>>>snapshot){
        if(!snapshot.hasData){
          return LoadingConatiner();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel>itemSnapshot){
            if(!itemSnapshot.hasData){
              return LoadingConatiner();
            }
            return buildTile(itemSnapshot.data,context);
          },
        );
      } ,
    );
  }
}


Widget buildTile(ItemModel item,BuildContext context){
  return Column(
    children: <Widget>[
      ListTile(
        onTap: (){
          Navigator.pushNamed(context,'/${item.id}');
        },
        title: Text(item.title),
        subtitle: Text('${item.score} votes'),
        trailing: Column(
          children:<Widget>[
            Icon(Icons.comment),
            Text('${item.descendants}')
          ],
          ),
      ),
      Divider(
        height: 8.0,
      ),
    ],
  );
}