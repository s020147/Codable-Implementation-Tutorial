import Foundation
//simple extraction with non-complex JSON
let baseURLLL = "https://jsonplaceholder.typicode.com/todos/1"
struct Swifter {
    let userIDx: Int
    let id: Int
    let title: String
    
}
extension Swifter: Decodable {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case userIDx = "userId"
        case id = "id"
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        // defining our (keyed) container
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        // extracting the data
        let userID = try container.decode(Int.self, forKey: MyStructKeys.userIDx)
        let id = try container.decode(Int.self, forKey: MyStructKeys.id)
        let title = try container.decode(String.self, forKey: MyStructKeys.title)
        
        // initializing our struct
        self.init(userIDx: userID, id: userID, title: title)
    }
}
func doSomething(){
let session: URLSession = .shared
session.dataTask(with: URL(string: baseURLLL)!){
    data,resp,error in
    do{
        let objs = try JSONDecoder().decode(Swifter.self, from: data!)// decoding our data
        print(objs)
    }catch{
        
    }
}.resume()
}


//array extraction
let baseURLL = "https://jsonplaceholder.typicode.com/todos"
struct Swifter2:Decodable{
    let userId: Int
    let id: Int
    let title: String
}
func doSomething2(){
    let session = URLSession.shared
    session.dataTask(with: URL(string: baseURLL)!){
        data,resp,error in
        do{
            let arrayObj = try JSONDecoder().decode([Swifter2].self, from: data!)
            print(arrayObj)
        }catch{
            print(error)
        }
    }.resume()
}
//doSomething2()
//complex struct
let baseURL = "https://samples.openweathermap.org/data/2.5/weather?q=&appid=eca0f332228da1d96333161ff4b66a10"
struct Coord:Decodable{
    var lon:Double
    var lat:Double
}
struct TempInfo:Decodable {
    var temp: Double
    var pressure:Double
    var humidity:Double
    var temp_min:Double
    var temp_max:Double
}
struct complexStruct:Decodable{
    var coord:Coord
    var main:TempInfo
}
func dosomething3(){
    let session:URLSession = .shared
    session.dataTask(with: URL(string: baseURL)!) {
        data,resp,err in
        do{
           let myMoreComplexStruct = try JSONDecoder().decode(complexStruct.self, from: data!)
            print(myMoreComplexStruct)
        }catch{
            print(err)
        }
    }.resume()
}
dosomething3()






