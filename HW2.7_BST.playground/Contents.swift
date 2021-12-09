import Cocoa

class BinarySearchStringTree{
    private(set) var value: String
    private(set) var parent: BinarySearchStringTree?
    private(set) var left: BinarySearchStringTree?
    private(set) var right: BinarySearchStringTree?
    
    init(value: String){
        self.value = value
    }
    
    private var count: Int{
        (left?.count ?? 0 ) + 1 + (right?.count ?? 0)
    }
    private var isRoot: Bool {
        parent == nil
     }

    private var isLeaf: Bool {
        left == nil && right == nil
     }

    private var isLeftChild: Bool {
        parent?.left === self
     }

    private var isRightChild: Bool {
        parent?.right === self
     }

    private var hasLeftChild: Bool {
        left != nil
     }

    private var hasRightChild: Bool {
        right != nil
     }

    private var hasAnyChild: Bool {
        hasLeftChild || hasRightChild
     }

    private var hasBothChildren: Bool {
        hasLeftChild && hasRightChild
     }
    
    func insert(value: String){
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchStringTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchStringTree(value: value)
                right?.parent = self
            }
        }
    }
    
    convenience init(array: [String]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for i in array.dropFirst(){
            insert(value: i)
        }
    }
    
    func search(value: String) -> BinarySearchStringTree? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value{
            return right?.search(value: value)
        } else {
            return self
        }
    }
}

extension BinarySearchStringTree: CustomStringConvertible {
    var description: String {
    var s = ""
    if let left = left {
      s += "(\(left.description)) <- "
    }
    s += "\(value)"
    if let right = right {
      s += " -> (\(right.description))"
    }
    return s
  }
}


let tree = BinarySearchStringTree(array: ["4444", "22", "1", "333", "55555"])

tree.insert(value: "666666")
tree.search(value: "22")
tree.search(value: "7777777")

