import SwiftUI

struct ContentView : View {
    @State private var currentTodo = ""
    @State private var todos: [Item] = []
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    TextField("Todo list", text: $currentTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        guard !self.currentTodo.isEmpty else{return}
                        self.todos.append(Item(todo: self.currentTodo))
                        self.currentTodo = ""
                    }){
                        Image(systemName: "text.badge.plus")
                    }
                    .padding(.leading, 5)
                }.padding()
                List{
                    ForEach(todos) { todoEntry in
                        Text(todoEntry.todo)
                    }.onDelete(perform : delete)/*Этот метод onDelete добавляет возможность удаления элементов из списка. Когда пользователь свайпает по элементу списка влево и нажимает кнопку "Delete", вызывается метод delete*/
                }
            }
            .navigationBarTitle("Todo List")
        }.onAppear(perform: load)
    }
    private func save(){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.todos), forKey: "myTodosTey" )
    }
    private func load(){
        if let todosData = UserDefaults.standard.value(forKey: "myTodosTey") as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<Item>.self,from: todosData){
                    self.todos = todosList
                }
            }
    }
    private func delete(at offset: IndexSet) {
        self.todos.remove(atOffsets: offset)
        save()
    }
}
 
