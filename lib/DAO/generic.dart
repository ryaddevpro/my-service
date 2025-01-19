import 'package:my_service/utils/snack_msg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GenericDAO<T> {
  final String tableName;
  final SupabaseClient supabase = Supabase.instance.client;

  GenericDAO(this.tableName);

  Future<List<T>> getAll(T Function(Map<String, dynamic>) fromJson) async {
    try {
      final res = await supabase.from(tableName).select();
      final List<dynamic> data = res as List<dynamic>;

      // Map the data to the model using fromJson and return the list
      final List<T> resultList =
          data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
      print("get all services: " + resultList[0].toString());
      return resultList;
    } catch (err) {
      showMessage("An error occurred while fetching data from $tableName: $err",
          isError: true);
      return [];
    }
  }

  // Fetch a record by a specific field
  Future<T?> getByField(String field, String value,
      T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response =
          await supabase.from(tableName).select().eq(field, value).single();

      if (response != null) {
        return fromJson(response);
      } else {
        showMessage("No data found for $field: $value");
        return null;
      }
    } catch (err) {
      showMessage("An error occurred while fetching data from $tableName: $err",
          isError: true);
      return null;
    }
  }

  // Create a record
  Future<bool> create(Map<String, dynamic> json) {
    return supabase.from(tableName).insert(json).then((response) {
      return true;
    }).catchError((err) {
      print(
        "error register $tableName Erreur: ${err}",
      );

      return false;
    });
  }

  Future<bool> update(
      String field, dynamic value, Map<String, dynamic> json) async {
    try {
      await supabase.from(tableName).update(json).eq(field, value);

      showMessage("Record updated successfully in $tableName");
      return true;
    } catch (err) {
      showMessage("Error updating record in $tableName: $err", isError: true);
      print("Error updating record in $tableName: $err");
      return false;
    }
  }

  // Delete a record by a specific field
  Future<bool> delete(String field, dynamic value) async {
    try {
      final response = await supabase.from(tableName).delete().eq(field, value);
      if (response.error != null) {
        showMessage(
            "Error deleting record from $tableName: ${response.error!.message}",
            isError: true);
        return false;
      }
      showMessage("Record deleted successfully from $tableName");
      return true;
    } catch (err) {
      showMessage("Error deleting record from $tableName: $err", isError: true);
      return false;
    }
  }
}
