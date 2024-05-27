import 'package:user_repository/src/entities/entities.dart';

class MyUser{
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart
  });

  static final empty = MyUser(
    userId: "", 
    email: "",
    name: "",
    hasActiveCart: false
  );

  MyUserEntity toEntity(){
    return MyUserEntity(
      email: email,
      name : name,
      userId : userId,
      hasActiveCart: hasActiveCart,
    );
  }

  static MyUser fromEntity(MyUserEntity entity){
    return MyUser(
      email: entity.email,
      name : entity.name,
      userId : entity.userId,
      hasActiveCart: entity.hasActiveCart,
    );


}

    @override
    String toString(){
      return "MyUser : $email, $name, $userId, $hasActiveCart";
    }
  }