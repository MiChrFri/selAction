import UIKit

private enum Consts {
  static let sideMargin: CGFloat = 18
}

class QuestionViewController: UIViewController {
  let question: Question
  
  init(with question: Question) {
    self.question = question
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addUI()
    self.addConstraints()
    self.setupView()
  }
  
  private func addUI() {
    self.view.addSubview(self.stackView)
    
    self.view.backgroundColor = .lightGray
  }
  
  private func addConstraints() {
    NSLayoutConstraint.activate([
      self.stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Consts.sideMargin),
      self.stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Consts.sideMargin),
      self.stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      self.stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

    ])
    
    for star in stars {
      NSLayoutConstraint.activate([
        star.widthAnchor.constraint(equalToConstant: 30),
        star.heightAnchor.constraint(equalToConstant: 30)
      ])
    }
  }
  
  private func setupView() {
    self.titleLabel.text = self.question.title
    self.questionLabel.text = self.question.question
  }
  
  // MARK: VIEWS
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.questionLabel, self.ratingView,  self.commentTextView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 8.0
    return stackView
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 42.0)
    label.numberOfLines = 0
    return label
  }()
  
  lazy var questionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24.0)
    label.numberOfLines = 0
    return label
  }()
  
  var stars = [UIView]()
  
  lazy var star: UIView = {
    var star = UIView()
    star.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
    star.translatesAutoresizingMaskIntoConstraints = false
    return star
  }()
  
  lazy var ratingView: UIStackView = {
     for i in 1...2 {
       stars.append(star)
     }
    
    let stackView = UIStackView(arrangedSubviews: [stars[0]])
    stackView.axis = .horizontal
    stackView.spacing = 30
    stackView.alignment = .fill
    stackView.distribution = .fill
    
    return stackView
  }()
  
  lazy var commentTextView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    textView.font = UIFont.systemFont(ofSize: 14.0)
    textView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    return textView
  }()
}
