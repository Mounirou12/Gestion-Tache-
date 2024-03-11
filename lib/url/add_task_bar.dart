import 'package:flutter/material.dart';
import 'package:gestion_tache/controllers/task_controllers.dart';
import 'package:gestion_tache/models/task.dart';
import 'package:gestion_tache/url/theme.dart';
import 'package:gestion_tache/url/widgets/button.dart';
import 'package:gestion_tache/url/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _dateSelection = DateTime.now();
  String _finHeure ="09:10 PM";
  String  _debutHeure = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _rappelSelect= 5;
  List<int> _listRappel=[
    5,
    10,
    15,
    20
  ];
  String _selecTedRepeat = "None" ;
  List<String> repeatList  =[
    "None",
    "Daily",
    "Weekly",
    "Month",
  ];

  int _selectedColor=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding:  EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                  "Add Task",
                style: headingStyle,
              ),
              MyInputField(title: "titre " ,hint: "Entrez le titre de la Tache" ,controller: _titleController,),
              MyInputField(title: "note " ,hint: "Entrez ta note",controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_dateSelection),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined,
                      color:Colors.grey
                  ),
                  onPressed: (){
                    print("HE,C'est la");
                    _getDateFromUser();
                  },
                ),),
              Row(
                children: [
                  Expanded(
                      child:MyInputField(
                        title: "heureDebut",
                        hint: _debutHeure,
                        widget: IconButton(
                            onPressed: (){
                              _getTimFromUser(isStartTime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            )
                        )
                      )
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                      child:MyInputField(
                          title: "finHeure",
                          hint: _finHeure,
                          widget: IconButton(
                              onPressed: (){
                                _getTimFromUser(isStartTime: false);
                              },
                              icon: Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey,
                              )
                          )
                      )
                  ),
                ],
              ),
              MyInputField(title: "rappel", hint: "$_rappelSelect minutes avant",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color:  Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _rappelSelect= int.parse(newValue!);
                    });
                  },
                  items: _listRappel.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem(
                      value: value.toString(),
                        child:Text(value.toString())
                    );
                  }
                ).toList(),
              )
              ),
              MyInputField(title: "repetition", hint: "$_selecTedRepeat ",
                  widget: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down,
                      color:  Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitleStyle,
                    underline: Container(height: 0,),
                    onChanged: (String? newValue){
                      setState(() {
                        _selecTedRepeat = newValue!;
                      });
                    },
                    items: repeatList.map<DropdownMenuItem<String>>((String? value){
                      return DropdownMenuItem(
                          value: value,
                          child:Text(
                              value!,
                              style:TextStyle(color: Colors.grey)
                          ),
                      );
                    }
                    ).toList(),
                  )
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(label: "creer Tache", onTap: ()=>_validate()),
                ],

              )
            ],
          ),
        ),
      ),
    );
  }

  _validate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
    }
    else if(_titleController.text.isEmpty||_noteController.text.isEmpty){

      Get.snackbar("Important", "Tous les champs sont a remplir",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.pink,
        icon: Icon(Icons.warning_amber_rounded)
      );


    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
    titre: _titleController.text,
    note: _noteController.text,
    date:  DateFormat.yMd().format(_dateSelection),
    debutHeure: _debutHeure,
    finHeure: _finHeure,
    repetition: _selecTedRepeat,
    rappel:_rappelSelect,
    couleur: _selectedColor,
    isCompleted:0,
    )

    );
    print("Mon id est "+ "$value");
  }
  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap:(){
          Get.back();
        },
        child:  Icon(Icons.arrow_back_ios,
            size: 20,
            color: Get.isDarkMode? Colors.white:Colors.black
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/profile.png"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }


  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Couleur",
          style:titleStyle ,
        ),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor=index;
                      print("$index");
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index==0?primaryClr:index==1?pinkClr:yellowClr,
                      child: _selectedColor==index?Icon(Icons.done,
                        color: Colors.white,
                        size: 16,
                      ):Container(),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
  _getDateFromUser() async{
    DateTime? _picKerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121)
    );
    if(_picKerDate!=null){
      setState(() {
        _dateSelection = _picKerDate;
        print(_dateSelection);
      });
    }else{
      print("C'est null ou quelque chose a deconne");
    }
  }
  _getTimFromUser({required bool? isStartTime}) async {
  var _pickedTime = await _showTimePicker();
  String _formatedTime = _pickedTime.format(context);
  if(_pickedTime==null){
    print("Temps annUle");
  }
  else if(isStartTime == true){
    setState(() {
      _debutHeure== _formatedTime;
    });
  }else if(isStartTime==false){
    setState(() {
      _finHeure==_formatedTime;
    });
  }
  }
  _showTimePicker(){
    return  showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_debutHeure.split(":")[0]),
            minute: int.parse(_debutHeure.split(":")[1].split(" ")[0]),
        ),
    );

}
}

