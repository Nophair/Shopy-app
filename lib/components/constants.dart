import 'package:shopy_app/components/components.dart';
import 'package:shopy_app/modules/login/login_screen.dart';
import 'package:shopy_app/network/local/cache_helper.dart';

void signOut(context) async {
  await CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if(value!)
    {
      navigateAndFinish(
        context, LoginScreen(),
      );
    }
  });
}

dynamic token = '';