import Foundation
import RealmSwift

class RealmQuestion: Object {
  @objc dynamic var title = ""
  @objc dynamic var question = ""
  @objc dynamic var comments = ""
  @objc dynamic var rating = 0.0
  
  static func build(_ question: Question) -> RealmQuestion {
      let realmQuestion = RealmQuestion()

    realmQuestion.title = question.title
    realmQuestion.question = question.question
    realmQuestion.comments = question.comments ?? ""
    realmQuestion.rating = question.rating ?? 0.0
    
    return realmQuestion
  }

}
