import "package:flutter_dotenv/flutter_dotenv.dart";

late Environment env;

Future<Environment> loadEnvironment() async {
  await dotenv.load();
  return Environment(
    appNamePostfix: dotenv.env["appNamePostfix"] ?? "prod",
    apiUrl: dotenv.env["API"] ?? "",
  );
}

class Environment {
  Environment({
    required this.apiUrl,
    required this.appNamePostfix,
  });

  final String appNamePostfix;
  final String apiUrl;
}
