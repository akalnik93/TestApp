import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.gradient.frame = self.view.bounds
        self.gradient.position = self.view.center
        self.view.layer.addSublayer(self.gradient)
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: idCustomCell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        constraintsForButtonForCreate()
        constraintsForTable()
        constraintsForButtonLabelForCreate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    var elementsArray = [Element]()
    
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 0.194, green: 0, blue: 0.312, alpha: 1).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        return gradient
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.text = "Клеточное наполнение"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idCustomCell = "idCustomCell"
    
    func scrollToLastRow() {
        let indexPathLastRow = IndexPath(row: elementsArray.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPathLastRow, at: .bottom, animated: true)
    }
    
    var buttonForCreate: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.353, green: 0.204, blue: 0.447, alpha: 1).cgColor
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createElement), for: .touchUpInside)
        return button
    }()
    
    var buttonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = "СОТВОРИТЬ"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func ifTrippleGetElementCondition() -> ElementCondition? {
        var trippleArray = [Element]()
        if elementsArray.count > 2 {
            trippleArray.append(contentsOf: elementsArray.dropFirst(elementsArray.count-3))
            let result = trippleArray.dropFirst().allSatisfy({$0.condition == trippleArray.first?.condition})
            if result {
                return trippleArray.first?.condition
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func ifTrippleCreateMessageElement() {
        let trippleCondition = ifTrippleGetElementCondition()
        if trippleCondition != nil {
            switch trippleCondition {
            case .live:
                self.elementsArray.append(Element(condition: .liveMessage))
            case .dead:
                self.elementsArray.append(Element(condition: .deadMessage))
            default:
                print("Произошла непредвиденная ошибка, свяжитесь с командой разработки")
            }
        }
    }

    @objc func createElement() {
        let newElement = Bool.random() ? Element(condition: .live) : Element(condition: .dead)
        self.elementsArray.append(newElement)
        self.ifTrippleCreateMessageElement()
        self.tableView.reloadData()
        self.scrollToLastRow()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: idCustomCell, for: indexPath) as! CustomCell
        cell.selectionStyle = .none
        cell.configureCell(element: elementsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}

extension ViewController {

    func constraintsForButtonForCreate() {
        self.view.addSubview(buttonForCreate)
        NSLayoutConstraint.activate([
            buttonForCreate.heightAnchor.constraint(equalToConstant: 36),
            buttonForCreate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            buttonForCreate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            buttonForCreate.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16)
            ])
    }
    
    func constraintsForButtonLabelForCreate() {
        self.buttonForCreate.addSubview(buttonLabel)
        NSLayoutConstraint.activate([
            buttonLabel.centerXAnchor.constraint(equalTo: self.buttonForCreate.centerXAnchor),
            buttonLabel.centerYAnchor.constraint(equalTo: self.buttonForCreate.centerYAnchor)
            ])
    }

    func constraintsForTable() {
        self.view.addSubview(tableView)
        self.headerLabel.frame = CGRect(x: self.tableView.bounds.origin.x, y: self.tableView.bounds.origin.y, width: self.tableView.bounds.width, height: 90)
        self.tableView.tableHeaderView = self.headerLabel
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.buttonForCreate.topAnchor, constant: -55)
            ])
    }

}
