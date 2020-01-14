class Global {
  static Map<dynamic, dynamic Function(dynamic)> get models =>
      <dynamic, dynamic Function(dynamic)>{
        // Examples:
        // DbConnectedUser: (data) => DbConnectedUser.fromJson(data),
        // UserMeta: (data) => UserMeta.fromJson(data),
        // DbMonitoring: (data) => DbMonitoring.fromJson(data),
        // DbBill: (data) => DbBill.fromJson(data),
        // DbConnectedUser: (data) => DbConnectedUser.fromJson(data),
      };

  // Data Models
  static T buildModel<T>(dynamic data) => models[T](data) as T;
}
