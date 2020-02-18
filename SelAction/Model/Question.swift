struct Question {
  let title: String
  let question: String
  let hints: String?
  var comments: String?
  var rating: Double?
  
  init(title: String, question: String, hints: String? = nil, comments: String? = nil, rating: Double? = nil) {
    self.title = title
    self.question = question
    self.hints = hints
    self.comments = comments
    self.rating = rating
  }
  
  init(realmQuestion: RealmQuestion) {
    self.title = realmQuestion.title
    self.question = realmQuestion.question
    self.hints = realmQuestion.hints
    self.comments = realmQuestion.comments
    self.rating = realmQuestion.rating
  }
}
