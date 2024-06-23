import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/input_fields.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String? name;
  String? about;
  String? number;


  @override
  void initState() {
    getDataSharedPreferences();
    // TODO: implement initState
    super.initState();
  }

  getDataSharedPreferences(){
    name = sp.getString("name");
    about= sp.getString("about");
    number = sp.getString("number");


  }
  saveDataSharedPreferences(String name, String about, String number){
    sp.setString("name", name);
    sp.setString("about", about);
    sp.setString("number", number);

  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isFile = !file.existsSync();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(

        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 2,
                      //color: Colors.indigoAccent,
                      child: Center(
                        child: InkWell(
                          child: isFile == false?CircleAvatar(
                            radius: 90,
                            backgroundImage: FileImage(file),
                          ):const CircleAvatar(
                            radius: 90,
                            backgroundImage: AssetImage("assets/images/logo.png"),
                          ),
                          onTap: () async {
                            final imgFile = await imagePicker.pickImage(source: ImageSource.gallery);
                            if (imgFile != null) {
                              await imgFile.saveTo(file.path);
                              //clear the cache image of that path, or else the image won't change
                              FileImage(file).evict();
                              isFile = true;
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  MyInputField(title: "Name*", hint: name!=null?name!:"Guest", controller: _nameController,),
                  MyInputField(title: "About", hint: about!=null?about!:"About",controller: _aboutController,),
                  MyInputField(
                    title: "Phone*",
                    hint: number!=null?number!:"+91 9998887776",
                    isInputNumber: true,
                    controller: _phoneController,
                    isMAX:true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        validateData();
                      },
                      child:  Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Theme.of(context).appBarTheme.backgroundColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  validateData(){
    if(_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty){
      saveDataSharedPreferences(_nameController.text, _aboutController.text, _phoneController.text);

      Navigator.pop(context);

    }
  }
}
