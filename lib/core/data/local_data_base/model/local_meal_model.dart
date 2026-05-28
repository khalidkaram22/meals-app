
class LocalMeal {
  final String id;
  final String name;
  final String imageUrl;
  final String time;
  final String instructions;
  final double rate;
  final String source; // "api" or "local"

  LocalMeal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.instructions,
    required this.rate,
    required this.source,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "time": time,
      "instructions": instructions,
      "rate": rate,
      "source": source,
    };
  }

  factory LocalMeal.fromMap(Map<String, dynamic> map) {
    return LocalMeal(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      time: map['time'],
      instructions: map['instructions'],
      rate: map['rate'],
      source: map['source']??"local",
    );
  }
}

