import 'package:hive/hive.dart';

class ToDoDataBase{

List todoList=[];

final mybox= Hive.box('mybox');

void createInitialData(){
      todoList=[
        ['Hit the gym', false],
        ['Shopsomegroceries', false],
      ];
}

void loadData (){
  todoList=mybox.get("TODOLIST");
}

void updateDataBase(){
  mybox.put("TODOLIST", todoList);
}


}