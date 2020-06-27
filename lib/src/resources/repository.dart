import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {

  List<Source> sources = <Source> [ newsDbProvider, NewsApiProvider(),];
  List<Cache> caches = <Cache> [ newsDbProvider ,];
  
  //Iterate over sources instead for real app
  Future<List<int>> fetchTopIds(){
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    // var item = await dbProvider.fetchItem(id);
    // if(item != null){
    //   return item;
    // }
    // item = await apiProvider.fetchItem(id);
    // dbProvider.addItem(item); // We can mark it await but we are not considered
    // return item;

    ItemModel item;
    Source source;
    for(source in sources){
      item = await source.fetchItem(id);
      if(item!=null){
        break;
      }
    }

    for(var cache in caches){
      cache.addItem(item);
    }
    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item); 
}