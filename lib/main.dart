import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'User profile '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();


  Future<void> _loadProfile() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameTextEditingController.text = prefs.getString('name')?? "";
      _emailTextEditingController.text = prefs.getString('email') ?? "";
    });
  }

  Future<void> _updateProfile() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('name', _nameTextEditingController.text);
      prefs.setString('email', _emailTextEditingController.text);
    });
  }

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
      //return Placeholder(); // a blank screen
     return Scaffold(
       appBar : AppBar(
         title: Text(widget.title),
         backgroundColor: Colors.orangeAccent, // title's background color
       ) , // small a for the widget , big A for scaffold

       body: Padding(padding: const EdgeInsets.all(8.0) ,
         child: Center(
           child: Column(
         children: [
           TextField(
             controller: _nameTextEditingController,
             keyboardType: TextInputType.name,
             decoration: const InputDecoration(
               labelText: 'Name'
             ),
           ),
           TextField(
             controller: _emailTextEditingController,
             keyboardType: TextInputType.emailAddress,
             decoration: const InputDecoration(
                 labelText: 'Email'
             ),
           ),
           Expanded(child: SizedBox()),
           ElevatedButton(
               onPressed: (){
                 _updateProfile();
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('${_nameTextEditingController.text} Your profile has been saved'),
                   ),
                 );
               },
               child: const Text('Save')
           ),

         ]
       ),),),


     );  // a blank white screen for scaffold

  }
}
