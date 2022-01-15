import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'post_api_service.g.dart';

@RestApi(baseUrl: "https://5e510330f2c0d300147c034c.mockapi.io/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @GET("/users")
  Future<List<Post>> getTasks();

}
@JsonSerializable()
class Post{
  String id;
  String name;
  String avatar;
  String email;

  Post({this.id, this.name, this.avatar, this.email});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    return data;
  }


}

