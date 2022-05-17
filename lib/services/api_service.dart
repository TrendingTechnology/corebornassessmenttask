import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> getAlbums() async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/albums");
      http.Response response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Bad status code');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to request network call: $e');
    }
  }

  Future<http.Response> getUsers() async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/users");
      http.Response response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Bad status code');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to request network call: $e');
    }
  }

  Future<http.Response> getPosts() async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      http.Response response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Bad status code');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to request network call: $e');
    }
  }

  Future<http.Response> getComments(int postId) async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId/comments");
      http.Response response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception('Bad status code');
      }
      return response;
    } catch (e) {
      throw Exception('Failed to request network call: $e');
    }
  }
}
