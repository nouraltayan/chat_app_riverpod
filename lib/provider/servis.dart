import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subabasefirstlctsher/model/modelchat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider((ref) => Supabase.instance.client);

abstract class Service {
  late SupabaseClient supabase;

  Future insertmasseg(chatmodel userModel);
}

class mssgService extends Service {
  mssgService(this.ref) {
    supabase = ref.watch(supabaseProvider);
  }

  final Ref ref;

  @override
  Future insertmasseg(chatmodel chat) async {
    final response = await supabase
        .from('Chat')
        .insert({"message": chat.message, "is_me": chat.is_me})
        .select()
        .single();
  }
}

final mssgServiceProvider = Provider<mssgService>((ref) {
  return mssgService(ref);
});

final chatStreamProviderget = StreamProvider.autoDispose((ref) {
  final supabase = ref.watch(supabaseProvider);
  return supabase.from('Chat').stream(primaryKey: ['*']).map(
      (data) => (data).map((map) => chatmodel.fromMap(map)).toList());
});


//no artcher
// final chatStreamProvidersend =
//     Provider.autoDispose.family<dynamic, chatmodel>((ref, chatmodel1) async{
//   final supabase = ref.watch(supabaseProvider);

//   return supabase.from('Chat').insert(
//       {"message": chatmodel1.message, "is_me": chatmodel1.is_me}).select();
// });