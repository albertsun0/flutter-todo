import 'package:flutter/material.dart';
import 'themes.dart';
import 'globals.dart';
import "package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart";
class Settings extends StatefulWidget{
  final ThemeBloc themeBloc;
  const Settings({Key key, this.themeBloc}) : super(key: key);
  @override
  _SettingState createState() => _SettingState();
}
bool darktheme = false;

class _SettingState extends State<Settings>{
  
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(  
            children: <Widget>[
              Center(
                child: Text("Options", style: TextStyle(fontSize: 25),),
              ),
              SizedBox(height: 10,),
              RaisedButton(
                onPressed: (){
                  darktheme = false;
                   //widget.themeBloc.selectedTheme.add(_buildLightTheme());
                  widget.themeBloc.selectedTheme.add(darktheme == false ? _buildLightTheme():_buildDarkTheme());
                },
                   
                child: Text(
                  'Light theme',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RaisedButton(
                  onPressed: (){
                    darktheme = true;
                     widget.themeBloc.selectedTheme.add(darktheme == false ? _buildLightTheme():_buildDarkTheme());
                  },
                  child: Text(
                    'Dark theme',
                  ),
                ),
              ),
              new ColorPicker(
                color: primaryC,
                onChanged: (value){
                   primaryC = value;
                   widget.themeBloc.selectedTheme.add(darktheme == false ? _buildLightTheme():_buildDarkTheme());
                   }
              ),

              new ColorPicker(
                color: accentC,
                onChanged: (value){
                   accentC = value;
                   widget.themeBloc.selectedTheme.add(darktheme == false ? _buildLightTheme():_buildDarkTheme());
                   }
              ),
            ],
          ),
        ),
      ),
    );
  }
  DemoTheme _buildLightTheme() {
    return DemoTheme(
        'light',
        ThemeData(
          brightness: Brightness.light,
          accentColor: accentC,
          primaryColor: primaryC,
        ));
  }

  DemoTheme _buildDarkTheme() {
    return DemoTheme(
        'dark',
        ThemeData(
          brightness: Brightness.dark,
          accentColor: accentC,
          primaryColor: primaryC,
        ));
  }
}

