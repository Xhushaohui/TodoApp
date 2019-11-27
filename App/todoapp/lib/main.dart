import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'UI/Intray/intray_page.dart';
import 'models/global.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/blocs/user_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getApiKey(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String apiKey = "";
        if (snapshot.hasData) {
          apiKey = snapshot.data;
          print("API KEY:" + snapshot.data);
          print("There is data");
        } else {
          print("There is nooR data");
        }
        return apiKey.length > 0
            ? getHomePage()
            : LoginPage(
                login: login,newUser: false,
              );
      },
    );
  }

  void login(){
    setState(() {
      build(context);
    });
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString("API_Token");
  }

  Widget getHomePage() {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
              body: Stack(
                children: <Widget>[
                  TabBarView(
                    children: [
                      IntrayPage(),
                      new Container(
                        color: Colors.orange,
                      ),
                      new Container(
                        child: Center(
                          child: FlatButton(
                            color: Colors.red,
                            child: Text("Log Out"),
                            onPressed: () {
                              logOut();
                            },
                          ),
                        ),
                        color: Colors.lightGreen,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    height: MediaQuery.of(context).size.height / 4.5,
                    // height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Intray",
                          style: intrayTitleStyle,
                        ),
                        Container()
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5.5,
                        left: MediaQuery.of(context).size.width * 0.5 - 35),
                    child: FloatingActionButton(
                      child: Icon(
                        Icons.add,
                        size: 60,
                      ),
                      backgroundColor: redColor,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: new TabBar(
                  tabs: [
                    Tab(
                      icon: new Icon(Icons.home),
                    ),
                    Tab(
                      icon: new Icon(Icons.rss_feed),
                    ),
                    Tab(
                      icon: new Icon(Icons.perm_identity),
                    ),
                  ],
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: Colors.transparent,
                ),
              ),
              backgroundColor: Colors.white),
        ),
      ),
    );
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("API_Token", "");
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
