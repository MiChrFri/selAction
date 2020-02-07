struct Candidate {
  let name: String
  let position: String
  var questions: [Question]
  
  init(name: String, position: String, questions: [Question]) {
    self.name = name
    self.position = position
    self.questions = questions
  }
  
  init(realmCandidate: RealmCandidate) {
    self.name = realmCandidate.name
    self.position = realmCandidate.position
    self.questions = []
    
    for q in realmCandidate.questions {
      self.questions.append( Question.init(realmQuestion: q))
    }
    
  }
}
