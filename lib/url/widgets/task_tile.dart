import 'package:flutter/material.dart';
import 'package:gestion_tache/models/task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gestion_tache/url/theme.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGClr(task?.couleur ?? 0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task?.titre ?? "",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${task!.debutHeure} - ${task!.finHeure}",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 13, color: Colors.grey[100]),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      task?.note ?? "",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task!.isCompleted == 1 ? "COMPLETED" : "TODDO",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
