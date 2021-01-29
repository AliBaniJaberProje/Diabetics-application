

class LoginController{

  bool personidValidation(String id){
    if(id.length<9)return false;
    if(id.isEmpty) return false;
    if(id.contains(new RegExp(r'[A-Z]'))) return false; 
    if(id.contains(new RegExp(r'[a-z]'))) return false;
  }
}