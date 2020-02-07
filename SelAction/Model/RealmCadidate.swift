import Foundation
import RealmSwift

class RealmCandidate: Object {
  @objc dynamic var name = ""
  @objc dynamic var position = ""
  let questions = List<RealmQuestion>()
  
  static func build(_ candidate: Candidate) -> RealmCandidate {
    let realmCandidate = RealmCandidate()

    realmCandidate.name = candidate.name
    realmCandidate.position = candidate.position
    
    let qs = candidate.questions.map { RealmQuestion.build($0) }
    
    realmCandidate.questions.append(objectsIn: qs)
    
    return realmCandidate
  }

}
