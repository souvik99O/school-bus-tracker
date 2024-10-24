class School {
  String id;
  String name;
  String image;
  List<RouteModel> routes;

  School({
    required this.id,
    required this.name,
    required this.image,
    required this.routes,
  });

  // Factory method to create School object from Firebase data
  factory School.fromMap(Map<String, dynamic> data, String id) {
    var routesData = data['routes'] as Map<String, dynamic>? ?? {}; // Handle null case
    List<RouteModel> routesList = routesData.entries
        .map((entry) => RouteModel.fromMap(entry.value, entry.key))
        .toList();

    return School(
      id: id,
      name: data['name'] ?? 'Unknown School', // Provide a default value if name is missing
      image: data['image'] ?? '', // If no image URL is provided, leave it empty
      routes: routesList,
    );
  }

  // Optional: Convert back to Map (if needed for other uses, like saving back to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'routes': routes.map((route) => route.toMap()).toList(),
    };
  }
}

class RouteModel {
  String id;
  String routeName;

  RouteModel({
    required this.id,
    required this.routeName,
  });

  // Factory method to create RouteModel from Firebase data
  factory RouteModel.fromMap(Map<String, dynamic> data, String id) {
    return RouteModel(
      id: id,
      routeName: data['routeName'] ?? 'Unknown Route', // Default value for missing route name
    );
  }

  // Optional: Convert back to Map (if needed for other uses, like saving back to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'routeName': routeName,
    };
  }
}
