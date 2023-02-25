abstract class ClientGeneric{
  Future<Map?> request(
      {
        String? url,
        String? method,
        Map<String, dynamic>? body
      });
}