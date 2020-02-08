import UIKit

private enum Consts {
  static let sideMargin: CGFloat = 18
}

class QuestionViewController: UIViewController {
  let question: Question
  let numberOfStars = 5
  var stars = [UIView]()
  
  init(with question: Question) {
    self.question = question
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addUI()
    addConstraints()
    setupView()
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
    titleLabel.text = question.title
    questionLabel.text = question.question
    hintLabel.text = "this is a hint"
  }
  
  private func colorStars(number: Int) {
    for i in 0..<number {
      stars[i].backgroundColor = .green
    }
    
    for i in number..<numberOfStars {
      stars[i].backgroundColor = .yellow
    }
  }
  
  private func createStars() -> [UIView] {
    let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
    let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
    let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
    let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
    let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
    
    let star1 = UIView()
    star1.backgroundColor = .yellow
    star1.tag = 1
    star1.translatesAutoresizingMaskIntoConstraints = false
    star1.addGestureRecognizer(tapGesture1)
    
    let star2 = UIView()
    star2.backgroundColor = .yellow
    star2.tag = 2
    star2.translatesAutoresizingMaskIntoConstraints = false
    star2.addGestureRecognizer(tapGesture2)
    
    let star3 = UIView()
    star3.backgroundColor = .yellow
    star3.tag = 3
    star3.translatesAutoresizingMaskIntoConstraints = false
    star3.addGestureRecognizer(tapGesture3)
    
    let star4 = UIView()
    star4.backgroundColor = .yellow
    star4.tag = 4
    star4.translatesAutoresizingMaskIntoConstraints = false
    star4.addGestureRecognizer(tapGesture4)
    
    let star5 = UIView()
    star5.backgroundColor = .yellow
    star5.tag = 5
    star5.translatesAutoresizingMaskIntoConstraints = false
    star5.addGestureRecognizer(tapGesture5)
    
    return [star1, star2, star3, star4, star5]
  }
  
  @objc private func starTapped(_ sender: UITapGestureRecognizer) {
    guard let starTag = sender.view?.tag else { return }
    
    let rating = starTag
    colorStars(number: starTag)
    
    ratingLabel.text = "\(rating) stars"
  }
  
  // MARK: VIEWS
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [
      titleLabel,
      questionLabel,
      hintLabel,
      ratingView,
      commentTextView])
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
  
  lazy var hintLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14.0)
    label.numberOfLines = 0
    return label
  }()
  
  lazy var questionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24.0)
    label.numberOfLines = 0
    return label
  }()
  
  lazy var ratingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24.0)
    label.numberOfLines = 1
    return label
  }()
    
  lazy var ratingView: UIStackView = {
    
    stars = createStars()
    
    let placeholder = UIView()
  
    
    let stackView = UIStackView(arrangedSubviews: stars)
    stackView.addArrangedSubview(placeholder)
    stackView.addArrangedSubview(ratingLabel)
    stackView.axis = .horizontal
    stackView.spacing = 30
    stackView.alignment = .leading
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
