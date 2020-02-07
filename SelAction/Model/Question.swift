struct Question {
  let title: String
  let question: String
  var comments: String?
  var rating: Double?
  
  init(title: String, question: String, comments: String? = nil, rating: Double? = nil) {
    self.title = title
    self.question = question
    self.comments = comments
    self.rating = rating
  }
  
  init(realmQuestion: RealmQuestion) {
    self.title = realmQuestion.title
    self.question = realmQuestion.question
    self.comments = realmQuestion.comments
    self.rating = realmQuestion.rating
  }
}
