import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url = 'https://zbievravqldwhyxifagy.supabase.co';
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpiaWV2cmF2cWxkd2h5eGlmYWd5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgzMDU4OTksImV4cCI6MjA2Mzg4MTg5OX0.sV0s_BCy8C-FY6jyzeLuHyRUBjWTcQAD18mxOTUarVM';

  static SupabaseClient get client => Supabase.instance.client;
}
