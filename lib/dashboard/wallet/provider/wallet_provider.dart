
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/wallet/models/wallet_response_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';

class WalletProvider extends ChangeNotifier{
  ApiCalls apiCalls = ApiCalls();
  WalletResponseModel? walletResponse;
  BuildContext? walletScreenContext;
  void getWalletData() async {
    // showLoaderDialog(walletScreenContext!);
    walletResponse = await apiCalls.getWalletData();
    if(walletResponse!.statusCode==200){
      // Navigator.pop(walletScreenContext!);
      notifyListeners();
    }else{
      // Navigator.pop(walletScreenContext!);
      showErrorToast(walletScreenContext!, walletResponse!.message!);
    }
  }
}