import 'package:flutter/cupertino.dart';

class PlayerModel extends ChangeNotifier {
  final int id;
  String pseudo;
  int _floor;
  int _gold;
  int _experience;
  int _damage = 1;
  int _bonusExp = 0;

  PlayerModel({
    this.id=0,
    this.pseudo="default",
    int floor=1,
    int gold=0,
    int experience=0,
  })  : _floor = floor,
        _gold = gold,
        _experience = experience;


  int get floor => _floor;
  int get gold => _gold;
  int get experience => _experience;
  int get damage => _damage;
  int get bonusExp => _bonusExp;


  void addGold(int amount) {
    _gold += amount;
    notifyListeners();
  }

  void addExperience(int amount) {
    _experience += amount + _bonusExp ;
    notifyListeners();
  }

  void advanceFloor() {
    _floor += 1;
    notifyListeners();
  }

  void setDamage(int totalDamage) {
    _damage = totalDamage;
    notifyListeners();
  }
  void setExperience(int exp){
    _experience = exp;
    notifyListeners();
  }

  void looseGold(int goldLoose){
    _gold = gold - goldLoose;
    notifyListeners();
  }

  void setBonusExperience(int exp){
    _bonusExp = exp;
    notifyListeners();
  }

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id_player'],
      pseudo: json['pseudo'],
      floor: json['floor'],
      gold: json['gold'],
      experience: json['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_player': id,
      'pseudo': pseudo,
      'floor': _floor,
      'gold': _gold,
      'experience': _experience,
    };
  }

  void reset(){
     _floor=1;
     _gold=0;
     _experience=0;
     _damage = 1;
     _bonusExp = 0;
  }


}
