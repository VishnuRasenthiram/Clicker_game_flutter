class Enhancement {
  final int id;
  final String name;
  final int goldCost;
  final int boostValue;
  final int idType;
  final String nameType;

  Enhancement({
    required this.id,
    required this.name,
    required this.goldCost,
    required this.boostValue,
    required this.idType,
    required this.nameType,
  });

  factory Enhancement.fromJson(Map<String, dynamic> json) {
    return Enhancement(
      id: json['id_enhancement'],
      name: json['nom'],
      goldCost: json['gold_cost'],
      boostValue: json['boost_value'],
      idType: json['id_type'],
      nameType: json['name_type'] ?? 'Unknown',
    );
  }
}