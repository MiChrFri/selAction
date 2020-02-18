import UIKit
import RealmSwift

class CandidateListViewController: UIViewController {
  private let candidateDataStore = CandidateDataStore()
  
  private let realm = try! Realm()
  private var candidates: [Candidate] = []
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
    
    loadCandidates()
    
    self.view.backgroundColor = .lightGray
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    loadCandidates()
  }
  
  private func addUI() {
    self.title = "Candidates"
    
    self.view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    navigationItem.rightBarButtonItems = [add]
  }
  
  @objc func addTapped() {
    let cVc = CreateCandidateViewController()
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
  
  private func loadCandidates() {
    candidates = candidateDataStore.load()
    tableView.reloadData()
  }
  
  private func populateWitDummyCandidates() {
    
    try? realm.write {
      realm.deleteAll()
    }
    
    let q1 = Question(title: "CS - Q1", question: "What's the difference between depenency injection and dependency inversion?")
    let q2 = Question(title: "CS - Q2", question: "What's the complexity of finding an entry in a hashMap?")
    let q3 = Question(title: "CS - Q3", question: "What's 1001 as a decimal number?")
    let q4 = Question(title: "iOS - Q1", question: "What's the differnce between frame and bounds?")
        
    let c1 = Candidate(name: "Mika", position: "iOS Ninja", questions: [q1, q2, q3, q4])
    let c2 = Candidate(name: "Steve", position: "Father of Apple", questions: [q2])
    
    let rc1 = RealmCandidate.build(c1)
    let rc2 = RealmCandidate.build(c2)
    
    candidateDataStore.save([rc1, rc2])
  }
    
}

extension CandidateListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return candidates.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
    cell.textLabel?.text = candidates[indexPath.row].name
    
    cell.textLabel?.font = Fonts.default
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cVc = CandidateViewController(with: candidates[indexPath.row])
    self.splitViewController?.showDetailViewController(cVc, sender: candidates[indexPath.row])
  }
  
}
