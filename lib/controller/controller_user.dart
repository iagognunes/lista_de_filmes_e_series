import 'package:get/get.dart';
import 'package:lista_de_filmes_e_series/model/user_name_model.dart';

class UserController extends GetxController {
  var user = UserName(name: "").obs; // declare como uma variavel qualquer

  void updateUserName(_currentUser) => user.value.name = _currentUser
      .toString(); // use .value e acesse qualquer variavel da classe

}
