import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gestion_tache/controllers/task_controllers.dart';
import 'package:gestion_tache/services/theme_services.dart';
import 'package:gestion_tache/url/add_task_bar.dart';
import 'package:gestion_tache/url/theme.dart';
import 'package:gestion_tache/url/widgets/button.dart';
import 'package:gestion_tache/url/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:gestion_tache/models/task.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());
    DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(),
      body:  Column(
        children:   [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10,),
          _showTasks(),
        ],
      ),
    );
  }


 _showTasks(){
    return Expanded(
        child: Obx((){
          return ListView.builder(
            itemCount: _taskController.taskList.length,
          itemBuilder: (_, index){
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if(task.repetition== 'Daily'){
                return AnimationConfiguration.staggeredList (
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child:Row(
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    _showBottomSheet(context, task);
                                  },
                                  child:TaskTile(task)
                              )
                            ],
                          )
                      ),
                    ));

              }

              if(task.date == DateFormat.yMd().format(_selectedDate)){
                return AnimationConfiguration.staggeredList (
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child:Row(
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    _showBottomSheet(context, task);
                                  },
                                  child:TaskTile(task)
                              )
                            ],
                          )
                      ),
                    ));

              }
              else{
                return Container();
              }

      });
    }),
    );
 }

 _showBottomSheet(BuildContext context,Task task){
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 4),
      height:  task.isCompleted==1?
      MediaQuery.of(context).size.height*0.24:
      MediaQuery.of(context).size.height*0.32,
      color: Get.isDarkMode?darkGreyClr:Colors.white,
        child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
            ),
          ),
          Spacer(),
          task.isCompleted==1
          ?Container()
              : _bottomSheetButton(
              label:"Tache complete",
              onTap: (){
                _taskController.markTaskCompleted(task.id!);
                Get.back();
              },
              clr:primaryClr,
              context:  context
          ),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
              label:"Supprimer tache",
              onTap: (){
                _taskController.delete(task);
                Get.back();
              },
              clr:Colors.red[300]!,
              context:  context
          ),
          _bottomSheetButton(
              label:"Fermer",
              onTap: (){
                Get.back();
              },
              clr:Colors.red[300]!,
              isClose: true,
              context:  context
          ),
          SizedBox(
            height: 10,
          ),
        ],
    ),

  )
  );
 }

 _bottomSheetButton({
    required String label,
   required Function()? onTap,
    required Color clr,
   bool isClose=false,
   required BuildContext context
}){
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        margin:  const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr
          ),
          borderRadius:  BorderRadius.circular(20),
            color: isClose==true?Colors.transparent:clr
        ),
        child: Center(
          child: Text(
            label,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
 }
  _addDateBar(){
    return  Container(
      margin:const  EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle:  TextStyle(
            fontSize:20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle:  TextStyle(
            fontSize:16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle:  TextStyle(
            fontSize:14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate=date;
          });
        },
      ),
    );
  }
  _addTaskBar(){
    return   Container(
     // margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: [
          Container(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",
                  style: headingStyle,),
              ],
            ),
          ),
          MyButton(label: "+Ajout Tache", onTap: () async {
            await Get.to(()=>AddTaskPage());
            _taskController.getTasks();
          }
          )
        ],
      ),
    );
  }
  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      leading: GestureDetector(
        onTap:(){
          ThemeService().switchTheme();
        },
        child:  Icon(Get.isDarkMode ?Icons.wb_sunny_outlined:Icons.nightlight_round,
        size: 20,
          color: Get.isDarkMode? Colors.white:Colors.black
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/profil.png"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}
