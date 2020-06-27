import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){
  test('FetchTopIds returns a list of ids', () async{
    //setup of test case
    // final sum = 1+3;
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1,2,3,4,5]),200);
    });
    //expectation
    final ids = await newsApi.fetchTopIds();
    // expect(sum, 4);
    expect(ids,[1,2,3,4,5]);
  });
  // test('Fetchitem returns a item model',() async{
  //   final newsApi = NewsApiProvider();
  //   newsApi.client = MockClient((request) async{
  //     final jsonMap = {'id':123};
  //     return Response(json.encode(jsonMap), 200);
  //   });
  //   final item = newsApi.fetchItem(123);
  //   expect(item,123);
  // });
}