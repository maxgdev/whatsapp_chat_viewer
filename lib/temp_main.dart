import 'package:flutter/material.dart';

class User {
  final String username, email, password,imageUrl;

  const User(
    {
    this.username,
    this.email,
    this.password,
    this.imageUrl,
    }
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //TextEditingController is controller for editable text fields.
  //It's role is to update itself and notify listeners whenever it's associated
  //textfield changes.
  var _usernameController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var _imageURLController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('Data Passing'),
      ),
      body: new Container(
        child: new Center(
          child: Column(
            children: <Widget>[
                Padding(
                  child: new Text(
                    'Type and Pass Data',
                    style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                    textAlign: TextAlign.center,
                    ),
                  padding: EdgeInsets.only(bottom: 20.0),
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                controller: _usernameController,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              new TextFormField(
                controller: _imageURLController,
                decoration: new InputDecoration(labelText: "Image URL"),
              ),
              new RaisedButton(
                onPressed: () {
                  // A MaterialPageRoute is a  modal route that replaces the entire screen
                  // with a platform-adaptive transition.
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new SecondPage(
                          value: User(
                                  username: _usernameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  imageUrl: _imageURLController.text
                                  )
                            ),
                  );
                  Navigator.of(context).push(route);
                },
                child: new Text('Click to Pass Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final User value;

  SecondPage({Key key, this.value}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Second Page')),
      body: new Container(
         child: new Center(
            child: Column(
              children: <Widget>[
                Padding(
                  child: new Text(
                    'PASSED VALUES',
                    style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                    textAlign: TextAlign.center,
                    ),
                  padding: EdgeInsets.only(bottom: 20.0),
                ),
                Padding(
                  //`widget` is the current configuration. A State object's configuration
                  //is the corresponding StatefulWidget instance.
                  child: Image.network( '${widget.value.imageUrl}'),
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                Padding(
                  child: new Text(
                    'USERNAME : ${widget.value.username}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                    ),
                  padding: EdgeInsets.all(10.0),
                ),
                Padding(
                  child: new Text(
                    'PASSWORD : ${widget.value.email}',
                     style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                    ),
                  padding: EdgeInsets.all(10.0),
                ),
                Padding(
                  child: new Text(
                    'PASSWORD : ${widget.value.password}',
                     style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                    ),
                  padding: EdgeInsets.all(10.0),
                )
                 ],   ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Home(),
      ),
    );
  }
}

void main() => runApp(new MyApp());