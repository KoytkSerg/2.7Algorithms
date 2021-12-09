import Cocoa

// 2

class LinkedListStringNode{
    var value: String
    var next: LinkedListStringNode?
    weak var previous: LinkedListStringNode?
    
    init(value: String){
        self.value = value
    }
}

class LinkedListString{
    typealias Node = LinkedListStringNode
    var count = 0
    let listName: String
    private var head: Node?
    
    var isEmpty: Bool{
        head == nil
    }
    
    public var first: Node?{
        head
    }
    
    public var last: Node? {
       guard var node = head else {
         return nil
       }
     
       while let next = node.next {
         node = next
       }
       return node
     }
    
    init(name: String){
        self.listName = name
    }
    
    func append(value: String){
        if isEmpty {
            self.insert(value, atIndex: 0)
        } else {
            self.insert(value, atIndex: count - 1)
        }
    }
    
    func node(atIndex index: Int) -> Node? {
        if isEmpty == true { print("List \(listName) is empty"); return nil}
        if index > count - 1 || index < 0{ print("bad index, use index in 0..\(count - 1) numbers"); return nil }
        if index == 0 {
          return head!
        } else {
          var node = head!.next
          for _ in 1..<index {
            node = node?.next
            if node == nil {
              break
            }
          }
          return node!
        }
      }
    
    public subscript(index: Int) -> String? {
        guard let node = node(atIndex: index) else { return nil }
        return node.value
      }

    func search(_ value: String) -> Bool?{
        var bool: Bool = false
        guard var node = head else {
            print("Can't find element because \(listName) is empty")
            return nil
            }
        
        if node.value == value{
            bool = true
            }
        while let next = node.next {
            node = next
            if node.value == value {
                bool = true
                }
            }
        
        return bool
    }
    
    func insert(_ value: String, atIndex index: Int){
        let newNode = Node(value: value)
        
        if index <= count && index >= 0{
            if index == 0 {
                count += 1
                newNode.next = head
                head?.previous = newNode
                head = newNode
            } else {
                count += 1
                let prev = self.node(atIndex: index - 1)!
                let next = prev.next
            
                newNode.previous = prev
                newNode.next = prev.next
                prev.next = newNode
                next?.previous = newNode
           }
        } else {print("bad index for insert, use index in 0..\(count - 1) numbers")}
    }
    
    func removeAll(){
        count = 0
        head = nil
    }
    
    func remove(_ node: Node) -> String?{
        if isEmpty { print("List \(listName) is empty"); return nil}
        let prev = node.previous
        let next = node.next
        
        if let prev = prev{
            prev.next = next
        } else {
            head = next
        }
        count -= 1
        next?.previous = prev
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    func removeLast() -> String?{
        if isEmpty {
            print("List \(listName) is empty"); return nil
        } else {
            count -= 1
            return remove(last!)!
        }
    }
    
    func remove(atIndex index: Int) -> String?{
        guard let node = node(atIndex: index) else { return nil }
        return remove(node)
    }
}

extension LinkedListString: CustomStringConvertible {
  public var description: String {
    var s = "["
    var node = head
    while node != nil {
      s += "\(node!.value)"
      node = node!.next
      if node != nil { s += ", " }
    }
    return s + "]"
  }
}

let list = LinkedListString(name: "Test")
list.append(value: "Hello")
list.count

list.append(value: "World")

list.isEmpty
list.first?.value
list.last?.value
list.count
list.insert("Swift", atIndex: 1)
list.count
//list.removeAll()
list[0]
list[1]
list[2]
list.removeAll()
list.remove(atIndex: 3)
list.count
list.removeAll()
list.removeLast()
list.search("Hello")
list.count
list.node(atIndex: 1)?.value
list
list.append(value: "test")
list
