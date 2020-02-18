import UIKit

final class CreateCandidateViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addUI()
    self.addConstraints()
  }
  
  private func addUI() {
    view.addSubview(nameTextView)
    view.addSubview(positionsTextView)
    
    view.backgroundColor = .lightGray
    
    let add = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    
    navigationItem.rightBarButtonItems = [add]
  }
  
  @objc func saveTapped() {
    guard let name = nameTextView.text, let position = positionsTextView.text else { return }
    
    let candidate = Candidate(name: name, position: position, questions: [])
    
    let dataStore = CandidateDataStore()
    dataStore.save(RealmCandidate.build(candidate))
    
    self.navigationController?.popViewController(animated: true)
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      nameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
      nameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18.0),
      nameTextView.heightAnchor.constraint(equalToConstant: 30),
      nameTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
      
      positionsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18.0),
      positionsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18.0),
      positionsTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 18)
    ])
  }
  
  // MARK: VIEWS
  
  lazy var nameTextView: UITextField = {
    let textField = UITextField()
    textField.font = .systemFont(ofSize: 28.0)
    textField.backgroundColor = .white
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
   
  lazy var positionsTextView: UITextField = {
    let textField = UITextField()
    textField.font = .systemFont(ofSize: 28.0)
    textField.backgroundColor = .white
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
}
