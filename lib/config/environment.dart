import "package:flutter_dotenv/flutter_dotenv.dart";

late Environment env;

Future<Environment> loadEnvironment() async {
  await dotenv.load();
  return Environment(
    apiUrl: dotenv.env["API"] ?? "",
  );
}

class Environment {
  Environment({
    required this.apiUrl,
  });

  final String apiUrl;
}
