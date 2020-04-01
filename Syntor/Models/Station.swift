import SwiftUI
import Combine

class Station: ObservableObject {
    @Published var tasks: [Task]
    
    var address: String
    var port: Int
    var login: String
    var password: String
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
        address = "my.synology.com"
        port = 5000
        login = "admin"
        password = ""
    }
    
    init(address: String, login: String, password: String, port: Int = 5000) {
        tasks = [Task]()
        self.address = address
        self.login = login
        self.password = password
        self.port = port
        Connect()
    }
    
    func Connect() -> String {
        let url = URL(string: "http://\(address):\(port)/webapi/auth.cgi?api=SYNO.API.Auth&version=2&method=login&account=\(login)&passwd=\(password)&session=DownloadStation&format=cookie")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(AuthorizationResponse.self, from: data)
                    print(parsedJSON)
                } catch {
                    print(error)
                }
            }
        }.resume()
        
        return "dsfsdf"
    }
}

#if DEBUG
let testStation = Station(tasks: [
    Task(id: 1, name: "Altered.Carbon.S02.WEBRip.2160p.H265.HDR"),
    Task(id: 2, name: "Homeland_Season_7_LostFilm_WEB-DL_1080p"),
    Task(id: 3, name: "What_We_Do_in_the_Shadows_Season_1_1080p_LostFilm"),
    Task(id: 4, name: "Sketch 64"),
])
#endif
