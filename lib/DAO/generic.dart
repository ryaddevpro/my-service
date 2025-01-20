import 'package:supabase_flutter/supabase_flutter.dart';

class GenericDAO<T> {
  final String tableName;
  final SupabaseClient supabase = Supabase.instance.client;

  GenericDAO(this.tableName);

  Future<List<T>> getAll(T Function(Map<String, dynamic>) fromJson) async {
    final res = await supabase.from(tableName).select();

    if (res is List) {
      return res.map((item) => fromJson(item as Map<String, dynamic>)).toList();
    } else {
      print("Error: The response is not a list");
      return [];
    }
  }

  // Fetch a record by a specific field
  Future<T?> getByField(String field, String value,
      T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response =
          await supabase.from(tableName).select().eq(field, value).single();

      // Check if response is valid and not null
      if (response != null) {
        return fromJson(response);
      } else {
        print("No record found for field $field with value $value");
        return null;
      }
    } catch (e) {
      // Handle errors (e.g., network issues, database errors)
      print("Error fetching record by field $field: $e");
      return null;
    }
  }

  // Create a record
  Future<bool> create(Map<String, dynamic> json) {
    return supabase.from(tableName).insert(json).then((response) {
      print(response);
      return true;
    }).catchError((err) {
      print("Error creating record in $tableName: ${err}");
      return false;
    });
  }

  // Update a record
  // Update a record
  Future<bool> update(
      String field, dynamic value, Map<String, dynamic> json) async {
    try {
      final response =
          await supabase.from(tableName).update(json).eq(field, value);

      if (response != null) {
        print("Error updating record: ${response.error!.message}");
        return false;
      }

      // If successful
      print("Record updated successfully");
      return true;
    } catch (e) {
      // Handle any errors (e.g., network issues, database errors)
      print("Error updating record in $tableName: $e");
      return false;
    }
  }

  // Delete a record by a specific field
  Future<bool> delete(String field, dynamic value) async {
    final response = await supabase.from(tableName).delete().eq(field, value);
    if (response != null) {
      return false;
    }
    return true;
  }
}
