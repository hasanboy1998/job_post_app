import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Login failed');
    }

    return UserModel(
      id: response.user!.id,
      email: response.user!.email!,
      createdAt: DateTime.parse(response.user!.createdAt!),
    );
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Sign up failed');
    }

    return UserModel(
      id: response.user!.id,
      email: response.user!.email!,
      createdAt: DateTime.parse(response.user!.createdAt!),
    );
  }

  @override
  Future<void> logout() async {
    await client.auth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = client.auth.currentUser;

    if (user == null) {
      return null;
    }

    return UserModel(
      id: user.id,
      email: user.email!,
      createdAt: DateTime.parse(user.createdAt!),
    );
  }
}