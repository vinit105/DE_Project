import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/theme_provider.dart';
import '../theme/light_theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? _groupSelectedValue;
  bool setNotifications = false;
  get g => null;
  TaskProvider taskProvider = TaskProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _groupSelectedValue ="English (United States)";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.language,size: 30,color: Colors.grey.shade800,),
              title: Text("Language",style: TextStyle(color: Colors.black),),
              subtitle: Text(_groupSelectedValue!,style: TextStyle(color: Colors.grey.shade800)),
              onTap: _alertDialog,
            ),
            ListTile(
              leading: Icon(Icons.notifications  ,size: 30,color: Colors.grey.shade800),
              title: Text("Notifications",style: TextStyle(color: Colors.black),),
              subtitle: Text("Show Notifications",style: TextStyle(color: Colors.grey.shade800),),
              trailing: Switch(
                value: setNotifications,
                activeColor: Colors.white,
                inactiveThumbColor: Colors.grey.shade600,
               inactiveTrackColor: Colors.grey.shade300,
               trackOutlineColor: MaterialStateProperty.all(Colors.black38),
               activeTrackColor: Colors.teal,
                onChanged: (value) {
                  setState(() {
                    setNotifications = !setNotifications;

                  });
                },),
              onTap: () {
                setState(() {
                  setNotifications = !setNotifications;

                });
              },
            ),
            ListTile(
              leading: Icon(Icons.dark_mode ,size: 30,color: Colors.grey.shade800),
              title: Text("Night mode",style: TextStyle(color: Colors.black)),
              subtitle: Text("Very dim display(for dark rooms)",style: TextStyle(color: Colors.grey.shade800)),
              trailing: Switch(
                value:ThemeProvider.getTheme()!=lightTheme?true:false,
                activeColor: Colors.white,
                activeTrackColor: Colors.teal,
                inactiveThumbColor: Colors.grey.shade600,
                trackOutlineColor: MaterialStateProperty.all(Colors.black38),
                inactiveTrackColor: Colors.grey.shade300,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                  taskProvider.changeTheme();

                },

              ),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();

                taskProvider.changeTheme();
              },
            ),
            ListTile(
              title: Text('Privacy Policy',style: TextStyle(color: Colors.black)),
              leading: Icon(Icons.policy,size: 30,color: Colors.grey.shade800),
              onTap: () async{
                final Uri _url = Uri.parse('https://drive.google.com/file/d/1HQeEiw--yf6EiuHI0ZKTSD_jZCH3h1tS/view?usp=drivesdk');
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
            ),
            ListTile(
              title: Text('Terms of Service',style: TextStyle(color: Colors.black)),
              leading: Icon(Icons.restore_page,size: 30,color: Colors.grey.shade800),
              onTap: () async{
                final Uri _url = Uri.parse('https://drive.google.com/file/d/1HQeEiw--yf6EiuHI0ZKTSD_jZCH3h1tS/view?usp=drivesdk');
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
            ),
            const ListTile(
              title: Text("Task Reminder",style: TextStyle(
                color: Colors.black38
              ),),
              subtitle: Text("1.0.0", style: TextStyle(
                  color: Colors.black38
              ),),
              leading: Icon(Icons.policy,size: 30,color: Colors.transparent,),
            )
          ],
        ),
      ),

    );


  }
  Future<void> _alertDialog() async{
    switch(await showDialog(context: context, builder: (BuildContext context){
      return SimpleDialog(
        title: Text("Language"),
        children: [
          ListTile(
            leading: Radio(
              value: "Albanian (Albania)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Albanian (Albania)"),
          ),
          ListTile(
            leading: Radio(
              value: "Arbaic",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Arbaic"),
          ),
          ListTile(
            leading: Radio(
              value: "Bangla (Bangladesh)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Bangla (Bangladesh)"),
          ),
          ListTile(
            leading: Radio(
              value: "Bangla (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Bangla (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "Bosnian (Bosnia& Herzegovina)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const Text("Bosnian (Bosnia& Herzegovina)"),
          ),
          ListTile(
            leading: Radio(
              value: "Bulgarian (Bulgaria)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const Text("Bulgarian (Bulgaria)"),
          ),
          ListTile(
            leading: Radio(
              value: "Cantonese (Hong Kong)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const Text("Cantonese (Hong Kong)"),
          ),
          ListTile(
            leading: Radio(
              value: "Catalan (Spain)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const Text("Catalan (Spain)"),
          )
          ,ListTile(
            leading: Radio(
              value: "cmm (China)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("cmm (China)"),
          )
          ,ListTile(
            leading: Radio(
              value: "Czech (Czechia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Czech (Czechia)"),
          )
          ,ListTile(
            leading: Radio(
              value: "Dainsh (Denmark)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Dainsh (Denmark)"),
          )
          ,ListTile(
            leading: Radio(
              value: "Dutuch (Belgium)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Dutuch (Belgium)"),
          ),
          ListTile(
            leading: Radio(
              value: "English (Australia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("English (Australia)"),
          ),
          ListTile(
            leading: Radio(
              value: "English (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("English (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "English (Nigeria)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("English (Nigeria)"),
          ),
          ListTile(
            leading: Radio(
              value: "English (United Kingdom)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("English (United Kingdom)"),
          ),
          ListTile(
            leading: Radio(
              value: "English (United States)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("English (United States)"),
          ),
          ListTile(
            leading: Radio(
              value: "Filipino (Finland)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Filipino (Finland)"),
          ),
          ListTile(
            leading: Radio(
              value: "French (Canada)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("French (Canada)"),
          ),
          ListTile(
            leading: Radio(
              value: "German (Germany)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("German (Germany)"),
          ),
          ListTile(
            leading: Radio(
              value: "Greek (Greece)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Greek (Greece)"),
          ),
          ListTile(
            leading: Radio(
              value: "Gujarati (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Gujarati (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "hebrew (Israel)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("hebrew (Israel)"),
          ),
          ListTile(
            leading: Radio(
              value: "Hindi (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Hindi (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "Hungarian (Hungary)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Hungarian (Hungary)"),
          ),
          ListTile(
            leading: Radio(
              value: "Indonesian (Indonesia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Indonesian (Indonesia)"),
          ),
          ListTile(
            leading: Radio(
              value: "Italian (Italy)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Italian (Italy)"),
          ),
          ListTile(
            leading: Radio(
              value: "Japanese (Japan)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Japanese (Japan)"),
          ),
          ListTile(
            leading: Radio(
              value: "Kannada (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Kannada (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "Khmer (Cambodia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Khmer (Cambodia)"),
          ),
          ListTile(
            leading: Radio(
              value: "Korean (Korea)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Korean (Korea)"),
          ),
          ListTile(
            leading: Radio(
              value: "Latvian (Latvia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Latvian (Latvia)"),
          ),
          ListTile(
            leading: Radio(
              value: "Malay (Malaysia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Malay (Malaysia)"),
          ),
          ListTile(
            leading: Radio(
              value: "Malayalam (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Malayalam (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "Marathi (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Marathi (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "Nepali (Nepal)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const Text("Nepali (Nepal)"),
          ),
          ListTile(
            leading: Radio(
              value: "Norwegian Bokmal (Norway)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Norwegian Bokmal (Norway)"),
          ),
          ListTile(
            leading: Radio(
              value: "Polish (Poland)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Polish (Poland)"),
          ),
          ListTile(
            leading: Radio(
              value: "Punjabi (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Punjabi (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "Russian (Russia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Russian (Russia)"),
          ),
          ListTile(
            leading: Radio(
              value: "Serbian",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Serbian"),
          ),
          ListTile(
            leading: Radio(
              value: "Slovak (Slovakia)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Slovak (Slovakia)"),
          ),
          ListTile(
            leading: Radio(
              value: "Spanish (Spain)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Spanish (Spain)"),
          ),
          ListTile(
            leading: Radio(
              value: "Tamil (India)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Tamil (India)"),
          ),
          ListTile(
            leading: Radio(
              value: "Turkish (Turkey)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Turkish (Turkey)"),
          ),
          ListTile(
            leading: Radio(
              value: "Thai (Thailand)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Thai (Thailand)"),
          ),
          ListTile(
            leading: Radio(
              value: "Ukrainian (Ukraine)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Ukrainian (Ukraine)"),
          ),
          ListTile(
            leading: Radio(
              value: "Urdu (Pakistan)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Urdu (Pakistan)"),
          ),
          ListTile(
            leading: Radio(
              value: "Vietnamese (Vietnam)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title: const Text("Vietnamese (Vietnam)"),
          ),
          ListTile(
            leading: Radio(
              value: "Welsh (United Kingdom)",
              groupValue: _groupSelectedValue,
              onChanged: _groupChange,
            ),
            title:const  Text("Welsh (United Kingdom)"),
          ),

        ],

      );
    }))
    {

    }
  }
  _groupChange(String? value){
    setState(() {
      _groupSelectedValue = value;
      Navigator.of(context).pop();
    });
  }
}
