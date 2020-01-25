import RealmSwift

final class QuestionDataStore: DataStore {
  typealias T = RealmQuestion
  typealias U = Question
  
  private let realm = try! Realm()
  
  func save(_ realmObject: RealmQuestion) {
    try? realm.write {
      realm.add(realmObject)
    }
  }
  
  func save(_ realmObjects: [RealmQuestion]) {
    try? realm.write {
      realm.add(realmObjects)
    }
  }
  
  func load() -> [Question] {
    return realm.objects(RealmQuestion.self)
      .compactMap { Question(realmQuestion: $0) }
  }
}
