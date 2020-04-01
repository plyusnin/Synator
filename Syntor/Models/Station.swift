import SwiftUI
import Combine

class Station: ObservableObject {
    @Published var tasks: [Task]
    
    var connected = false
    
    private var address: String
    private var port: Int
    private var login: String
    private var password: String
    
    private var refreshingTimer: Timer?
    
    let jsonDecoder = JSONDecoder()
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
        address = "my.synology.com"
        port = 5000
        login = "admin"
        password = ""
        refreshingTimer = nil
    }
    
    init(address: String, login: String, password: String, port: Int = 5000) {
        tasks = [Task]()
        self.address = address
        self.login = login
        self.password = password
        self.port = port
        
        Connect() { result in
            self.UpdateTasks()
            self.connected = true
        }
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if (self.connected)
            {
                self.UpdateTasks()
            }
        })
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        self.refreshingTimer = timer
    }
    
    func Connect(completion: @escaping((Result<String, Error>) -> Void)) {
        let url = URL(string: "http://\(address):\(port)/webapi/auth.cgi?api=SYNO.API.Auth&version=2&method=login&account=\(login)&passwd=\(password)&session=DownloadStation&format=cookie")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let parsedJSON = try self.jsonDecoder.decode(Response<AuthorizationData>.self, from: data)
                    completion(.success(parsedJSON.data.sid))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func UpdateTasks() -> Void {
        let url = URL(string: "http://\(address):\(port)/webapi/DownloadStation/task.cgi?api=SYNO.DownloadStation.Task&version=1&method=list&additional=detail,file,transfer,tracker,peer")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let parsedJSON = try self.jsonDecoder.decode(Response<TaskListData>.self, from: data)
                    let newTasks = parsedJSON.data.tasks.map({Task(id: $0.id, name: $0.title)})
                    DispatchQueue.main.async {
                        self.tasks = newTasks
                        print("updated!")
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

#if DEBUG
let testStation = Station(tasks: [
    Task(id: "1", name: "Altered.Carbon.S02.WEBRip.2160p.H265.HDR"),
    Task(id: "2", name: "Homeland_Season_7_LostFilm_WEB-DL_1080p"),
    Task(id: "3", name: "What_We_Do_in_the_Shadows_Season_1_1080p_LostFilm"),
    Task(id: "4", name: "Sketch 64"),
])
#endif
