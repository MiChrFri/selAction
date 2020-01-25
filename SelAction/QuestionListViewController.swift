import UIKit
import RealmSwift

class QuestionListViewController: UIViewController {
  private let questionDataStore = QuestionDataStore()
  private let realm = try! Realm()
  private var questions: [Question] = []
  private var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    
    self.addUI()
    self.addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    populateWitDummyQuestions()
    
    self.view.backgroundColor = .lightGray
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadQuestions()
  }
  
  private func addUI() {
    self.title = "Questions"
    
    self.view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    navigationItem.rightBarButtonItems = [add]
  }
  
  @objc func addTapped() {
    let cVc = CreateQuestionViewController()
    self.navigationController?.pushViewController(cVc, animated: true)
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func loadQuestions() {
    questions = questionDataStore.load()
    tableView.reloadData()
  }
  
  private func populateWitDummyQuestions() {
    
    try? realm.write {
      realm.deleteAll()
    }

    print("📍 \(Realm.Configuration.defaultConfiguration.fileURL)")
    
    let q1 = Question(title: "CS - Q1", question: "What's the difference between depenency injection and dependency inversion?")
    let q2 = Question(title: "CS - Q2", question: "What's the complexity of finding an entry in a hashMap?")
    let q3 = Question(title: "CS - Q3", question: "What's 1001 as a decimal number?")
    let q4 = Question(title: "iOS - Q1", question: "What's the differnce between frame and bounds?")
    
    let rq1 = RealmQuestion.build(q1)
    let rq2 = RealmQuestion.build(q2)
    let rq3 = RealmQuestion.build(q3)
    let rq4 = RealmQuestion.build(q4)
    
    questionDataStore.save([rq1, rq2, rq3, rq4])
  }
  
}

extension QuestionListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
    cell.textLabel?.text = questions[indexPath.row].title
    
    cell.textLabel?.font = Fonts.default
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let qVc = QuestionViewController(with: questions[indexPath.row])
    self.splitViewController?.showDetailViewController(qVc, sender: nil)
  }
  
}
