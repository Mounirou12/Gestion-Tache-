
class Task {
  int? id;
  String? titre;
  String? note;
  int? isCompleted;
  String? date;
  String? debutHeure;
  String? finHeure;
  int? rappel;
  String? repetition;
  int? couleur;

  Task({
    this.id,
    this.titre,
    this.note,
    this.date,
    this.debutHeure,
    this.finHeure,
    this.rappel,
    this.repetition,
    this.couleur,
    this.isCompleted,
});
  Task.fromJson(Map<String,dynamic> json){
    id = json['id'];
    titre = json['titre'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    debutHeure = json['debutHeure'];
    finHeure = json['finHeure'];
    rappel = json['rappel'];
    repetition = json['repetition'];
    couleur = json['couleur'];

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new  Map<String,dynamic>();
    data['id'] = this.id;
    data['titre'] = this.titre;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['debutHeure'] = this.debutHeure;
    data['finHeure'] = this.finHeure;
    data['rappel'] = this.rappel;
    data['repetition'] = this.repetition;
    data['couleur'] = this.couleur;
     return data;
}

}
