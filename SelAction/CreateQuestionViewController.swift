import UIKit

final class CreateQuestionViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addUI()
    self.addConstraints()
  }
  
  private func addUI() {
    view.addSubview(stackView)
    view.backgroundColor = .lightGray
    
    let add = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    
    navigationItem.rightBarButtonItems = [add]
  }
  
  @objc func saveTapped() {
    let question = Question(title: titleTextView.text, question: questionTextView.text)
    let dataStore = QuestionDataStore()
    dataStore.save(RealmQuestion.build(question))
    
    
    self.navigationController?.popViewController(animated: true)
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
  
  // MARK: VIEWS
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleTextView, questionTextView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 8.0
    return stackView
  }()
  
  lazy var titleTextView: UITextView = {
    let textView = UITextView()
    textView.font = UIFont.systemFont(ofSize: 42.0)
    textView.backgroundColor = .white
    return textView
  }()
  
  lazy var questionTextView: UITextView = {
    let textView = UITextView()
    textView.font = UIFont.systemFont(ofSize: 24.0)
    textView.backgroundColor = .white
    return textView
  }()
}
