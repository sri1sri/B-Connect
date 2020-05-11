class Vehicle {
  Vehicle({
    this.name,
  });

  String name;

  factory Vehicle.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    final String name = data['name'];

    return Vehicle(
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      name != null ? 'name' : 'empty': name,
    };
  }
}
