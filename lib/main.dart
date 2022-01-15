import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_flutter/post_api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  RetrofitPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class RetrofitPage extends StatefulWidget{
  RetrofitPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  RetrofitPageState createState() => RetrofitPageState();

}

class RetrofitPageState extends State<RetrofitPage> {
  var connectionStatus;
  var _scafoldkey = GlobalKey<ScaffoldState>();

  void Call_API() {
    setState(() {
      build_api(context);
    });
  }

  void Show_Toast(){
    Fluttertoast.showToast(msg: "No Internet",toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scafoldkey,
      appBar: new AppBar(
        title: new Text(
          "MTT",
          style: new TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ConnectivityWidget(
        onlineCallback: Call_API,
        offlineCallback: Show_Toast,
        builder: (context, isOnline)  => Center(
          child: build_api(context),
        ),

      ),
    );
  }

}

FutureBuilder<List<Post>> build_api(BuildContext context) {
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<List<Post>>(
    future: client.getTasks(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<Post> posts = snapshot.data;
        if(snapshot.data!=null){
          return _buildPosts(context, posts);
        }else{
          return Center(
            // child: CircularProgressIndicator(),
          );
        }
      }else{
        return Center(
          child: CircularProgressIndicator(),
          // child: CupertinoActivityIndicator(),
        );
      }
    },
  );
}

ListView _buildPosts(BuildContext context, List<Post> posts) {
  return ListView.builder(
    itemCount: posts.length,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      print(posts[index].avatar);
      return Container(
          padding: EdgeInsets.all(3),
          height: 120,
          child: Card(
              child: new InkWell(
                  onTap: (){

                  },

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: <Widget>[
                        // Image.network(posts[index].avatar),
                        Image.network('https://picsum.photos/250?image=9'),

                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(posts[index].name,
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(posts[index].email),
                                    /*Text("Price: " + card_data[position].price.toString()),*/
                                  ],
                                )))

                      ]))));

    },
  );
}


