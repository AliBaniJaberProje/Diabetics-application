// import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
// import 'package:ali_muntaser_final_project/core/Servies_api/login_api.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
//
// class LoginController {
//   BuildContext context;
//   LoginApiFireBase apiLoginFirbase;
//
//   LoginController(BuildContext context){
//     this.context=context;
//     apiLoginFirbase=new LoginApiFireBase();
//   }
//
//   bool personidValidation(String id) {
//     if (id.length < 9) return false;
//     if (id.isEmpty) return false;
//     if (id.contains(new RegExp(r'[A-Z]'))) return false;
//     if (id.contains(new RegExp(r'[a-z]'))) return false;
//   }
//
//   Future<bool> isLogin(String id, String password) async {
//     if (await this.apiLoginFirbase.isLogin(id, password)) {
//       this.context.read<ProfileProvider>().setId(id);
//       this.context.read<ProfileProvider>().setImgUrl(this.apiLoginFirbase.getImgUrl());
//       return true;
//     }
//     return false;
//   }
// }
