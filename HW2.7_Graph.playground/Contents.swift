import Cocoa
import Foundation

class Vertex {
    var data: String = ""
    var visited = false
    var edges: [Edge] = []
}

extension Vertex: CustomStringConvertible {
  var description: String {
    return "\(data)"
  }
}


enum EdgeType{
    case directed, undirected
}

class Edge{
    var source: Vertex
    var destination: Vertex
    let weight: Double
    
    init(start: Vertex, finish: Vertex, weight: Double) {
      assert(weight >= 0, "weight has to be equal or greater than zero")
        self.source = start
        self.destination = finish
        self.weight = weight
      }
    
}

class AdjacencyList{
    var vertexArray: [Vertex] = []
    
   
    private func addDirectedEdge(from source: Vertex, to destination: Vertex, weight: Double) {
      let edge = Edge(start: source, finish: destination, weight: weight)
        source.edges.append(edge)
    }
    
    private func addUndirectedEdge(vertices: (Vertex, Vertex), weight: Double) {
      let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    func createVertex(data: String) -> Vertex {
        let vertex = Vertex()
        vertex.data = data
        vertexArray.append(vertex)
      return vertex
    }
    
    func add(_ type: EdgeType, from source: Vertex, to destination: Vertex, weight: Double?) {
      switch type {
      case .directed:
          addDirectedEdge(from: source, to: destination, weight: weight!)
      case .undirected:
        addUndirectedEdge(vertices: (source, destination), weight: weight!)
      }
    }
    
    func weight(from source: Vertex, to destination: Vertex) -> Double? {
        for edge in source.edges where !source.edges.isEmpty{
        if edge.destination === destination { /// !!!!!!!
          return edge.weight
        }
      }
        return nil
    }
    
    func streightConnections(from source: Vertex) -> [Vertex]?{

        var result: [Vertex] = []
        for edge in source.edges where !source.edges.isEmpty{
            result.append(edge.destination)
        }
        return result
    }
    
    var description: CustomStringConvertible {
      var result = " "
      for vertex in vertexArray {
        var edgeString = ""
          for (index, edge) in vertex.edges.enumerated() {
          if index != vertex.edges.count - 1 {
            edgeString.append("\(edge.destination), ")
          } else {
            edgeString.append("\(edge.destination)")
          }
        }
        result.append("\(vertex) ---> [ \(edgeString) ] \n ")
      }
        return result
    }
}

class DijkstraAlgorithm{
    private(set) var from: Vertex
    private(set) var to: Vertex
    private(set) var routeArray: [Vertex]? = []
    private(set) var routeString: String = ""
    private(set) var totalWeight: Double?
    
    init(from: Vertex, to: Vertex){
        self.from = from
        self.to = to
        self.routeArray = shortestPath()?.array.reversed()
        self.routeString = stringShortestPath()
    }
    
    class Path {
        public let cumulativeWeight: Double
        public var node: Vertex
        public let previousPath: Path?
        
        init(to node: Vertex, via connection: Edge? = nil, previousPath path: Path? = nil) {
          if
            let previousPath = path,
            let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
          } else {
            self.cumulativeWeight = 0
          }
          
          self.node = node
          self.previousPath = path
        }
        
      var array: [Vertex] {
        var array: [Vertex] = [self.node]
        
        var iterativePath = self
        while let path = iterativePath.previousPath {
          array.append(path.node)
          
          iterativePath = path
        }
          return array
      }
    }

    private func shortestPath() -> Path? {
        var frontier: [Path] = [] {
          didSet { frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } }
        }
        
        frontier.append(Path(to: self.from))
        
        while !frontier.isEmpty {
        let cheapestPathInFrontier = frontier.removeFirst()
        guard !cheapestPathInFrontier.node.visited else { continue }
          
            if cheapestPathInFrontier.node === self.to {
            return cheapestPathInFrontier // found the cheapest path
          }
          
        cheapestPathInFrontier.node.visited = true
          
        for connection in cheapestPathInFrontier.node.edges where !connection.destination.visited {  frontier
            frontier.append(Path(to: connection.destination, via: connection, previousPath: cheapestPathInFrontier))
          }
        }
        return nil 
    }
    
    private func stringShortestPath() -> String{
        guard let path = routeArray else {
            return "There is no way between \(self.from) and \(self.to)"
        }
        var result = "Your route:"
        let info = path.map({ $0.data})
        for i in info{
            result += "\n\(i)"
        }
        return result
    }
        
}


let stationsList = AdjacencyList()

var station1 = stationsList.createVertex(data: "station 1")
var station2 = stationsList.createVertex(data: "station 2")
var station3 = stationsList.createVertex(data: "station 3")
var station4 = stationsList.createVertex(data: "station 4")
var station5 = stationsList.createVertex(data: "station 5")
var station6 = stationsList.createVertex(data: "station 6")

stationsList.add(.undirected, from: station1, to: station2, weight: 10)
stationsList.add(.undirected, from: station2, to: station3, weight: 20)
stationsList.add(.undirected, from: station3, to: station4, weight: 10)
stationsList.add(.undirected, from: station4, to: station5, weight: 10)
//stationsList.add(.undirected, from: station4, to: station6, weight: 30)
//stationsList.add(.undirected, from: station3, to: station5, weight: 20)
print(stationsList.description)

let route1 = DijkstraAlgorithm(from: station1, to: station4)
print(route1.routeArray)
print(route1.routeString)
let route2 = DijkstraAlgorithm(from: station1, to: station6)
print(route2.routeArray)
print(route2.routeString)




