import RealmSwift

final class CandidateDataStore: DataStore {
  
  typealias T = RealmCandidate
  typealias U = Candidate
  
  private let realm = try! Realm()
  
  func save(_ realmObject: RealmCandidate) {
    try? realm.write {
      realm.add(realmObject)
    }
  }
  
  func save(_ realmObjects: [RealmCandidate]) {
    try? realm.write {
      realm.add(realmObjects)
    }
  }
  
  func load() -> [Candidate] {
    return realm.objects(RealmCandidate.self)
      .compactMap { Candidate(realmCandidate: $0) }
  }
}
