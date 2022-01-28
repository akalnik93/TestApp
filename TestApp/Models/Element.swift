import Foundation
import UIKit

enum ElementCondition {
    
    case live
    case dead
    
    case liveMessage
    case deadMessage

}

struct Element {
    
    var condition: ElementCondition
    var title: String
    var comment: String
    var picture: UIImage?
    var subPicture: UIImage?
    
    init(condition: ElementCondition) {
        self.condition = condition
        
        switch condition {
        
        case .live:
            self.title = "Живая"
            self.comment = "и шевелится"
            self.picture = UIImage(named: "live fond")
            self.subPicture = UIImage(named: "live")
        
        case .dead:
            self.title = "Мёртвая"
            self.comment = "или прикидывается"
            self.picture = UIImage(named: "dead fond")
            self.subPicture = UIImage(named: "dead")
        
        case .liveMessage:
            self.title = "Жизнь"
            self.comment = "Ку-ку"
            self.picture = UIImage(named: "liveMessage fond")
            self.subPicture = UIImage(named: "liveMessage")
        
        case .deadMessage:
            self.title = "Смерть"
            self.comment = "Бай-бай"
            self.picture = UIImage(named: "deadMessage fond")
            self.subPicture = UIImage(named: "deadMessage")
        }
    }

}
