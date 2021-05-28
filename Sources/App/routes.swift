import Vapor

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<View> in
        let context = [String: String]()
        return req.view.render("home", context)
    }
    
    app.get("contact") { req -> EventLoopFuture<View> in
        let context = [String: String]()
        return req.view.render("contact", context)
    }
    
    app.get("staff", ":name") { req -> EventLoopFuture<View> in
        let name = req.parameters.get("name")
        
        let bios = ["kirk": "My name is James Kirk and I love snakes.",
        "picard": "My name is Jean-Luc Picard and I'm mad for fish.",
        "sisko": "My name is Benjamin Sisko and I'm all about the budgies.",
        "janeway": "My name is Kathryn Janeway and I want to hug every hamster.",
        "archer": "My name is Jonathan Archer and beagles are my thing."
    ]
        struct StaffView: Codable {
            var name: String?
            var bio: String?
            var allNames: [String]
        }
        
        let context: StaffView
        if let name = name {
            let bio = bios[name]
            context = StaffView(name: name, bio: bio, allNames: bios.keys.sorted())
        }else{
            context = StaffView(name: nil, bio: nil, allNames: bios.keys.sorted())
        }
        return req.view.render("staff", context)
    }
}
