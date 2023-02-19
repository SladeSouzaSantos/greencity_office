abstract class ClientGeneric{
  Future<void>? request(
      {
        String? url,
        String? method,
        Map<String, dynamic>? body
      });
}