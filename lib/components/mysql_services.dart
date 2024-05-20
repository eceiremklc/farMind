import 'package:mysql_client/mysql_client.dart';

Future<void> connectToMySQL() async {
  print("Connecting to mysql server...");

  try {
    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "localhost",
      port: 3306,
      userName: "root",
      password: "4468219c",
      //databaseName: "tarim", // optional
    );

    await conn.connect();

    print("Connected");
  } catch (e) {
    print("Connection failed: $e");
  }
}
