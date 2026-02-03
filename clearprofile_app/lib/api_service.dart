class ApiService {
  /// Mock Login Action
  static Future<void> loginStart(String username, String password) async {
    // TODO: Connect to backend
    print("ApiService: Login started for $username");
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
  }

  /// Mock Analyze/Ingest Action
  static Future<void> ingestInstagram(String handle) async {
    // TODO: Connect to backend
    print("ApiService: Ingesting Instagram for $handle");
    await Future.delayed(const Duration(seconds: 2)); // Simulate network
  }
}
