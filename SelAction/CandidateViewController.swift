import UIKit
import RealmSwift

protocol CandidateViewControllerDelegate: class {
  
  func didOpenQuestion()
  
}

class CandidateViewController: UIViewController {
  private let candidate: Candidate
  weak var delegate: CandidateViewControllerDelegate?
  
  convenience init() {
    self.init(with: Candidate(name: "Hola", position: "😃", questions: []))
  }
  
  init(with candidate: Candidate) {
    self.candidate = candidate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    self.view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    
    self.addUI()
    self.addConstraints()
    
    questionsButton.addTarget(self, action: #selector(openQuestions), for: .touchUpInside)
  }

  private func addUI() {
    view.addSubview(nameLabel)
    view.addSubview(positionLabel)
    view.addSubview(questionsButton)
  }
  
  @objc func openQuestions() {

    guard let q1 = candidate.questions.first else {
      assertionFailure("No Questions")
      return
    }
    
    let qVc = QuestionViewController(with: q1)

    
    splitViewController?.show(qVc, sender: nil)
    
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: positionLabel.topAnchor, constant: -18.0),
      
      positionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      positionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      positionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      questionsButton.widthAnchor.constraint(equalToConstant: 300),
      questionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      questionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -42.0),
      questionsButton.heightAnchor.constraint(equalToConstant: 80.0),
    ])
  }

  // UI Definition
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = candidate.name
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var positionLabel: UILabel = {
    let label = UILabel()
    label.text = candidate.position
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var questionsButton: UIButton = {
    let button = UIButton()
    button.setTitle("Start", for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
}
