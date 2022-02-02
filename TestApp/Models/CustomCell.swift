import UIKit

class CustomCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.setConstraintsCellContainer()
        self.setConstraintsCellPicture()
        self.setConstraintsCellTitle()
        self.setConstraintsCellContent()
        self.setConstraintsCellSubPicture()
    }
    
    var cellTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellComment: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var cellSubPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var cellContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configureCell(element: Element) {
        self.cellTitle.text = element.title
        self.cellComment.text = element.comment
        self.cellPicture.image = element.picture
        self.cellSubPicture.image = element.subPicture
    }
    
}

extension CustomCell {
    
    func setConstraintsCellContainer() {
        self.addSubview(cellContainer)
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cellContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            cellContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
    }
    
    func setConstraintsCellTitle() {
        self.cellContainer.addSubview(cellTitle)
        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: self.cellPicture.topAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: self.cellPicture.trailingAnchor, constant: 16),
            cellTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellTitle.heightAnchor.constraint(equalToConstant: 28)
            ])
    }
    
    func setConstraintsCellContent() {
        self.cellContainer.addSubview(cellComment)
        NSLayoutConstraint.activate([
            cellComment.bottomAnchor.constraint(equalTo: self.cellContainer.bottomAnchor, constant: -9),
            cellComment.leadingAnchor.constraint(equalTo: self.cellTitle.leadingAnchor),
            cellComment.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellComment.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    func setConstraintsCellPicture() {
        self.cellContainer.addSubview(cellPicture)
        NSLayoutConstraint.activate([
            cellPicture.widthAnchor.constraint(equalToConstant: 40),
            cellPicture.heightAnchor.constraint(equalToConstant: 40),
            cellPicture.leadingAnchor.constraint(equalTo: self.cellContainer.leadingAnchor, constant: 16),
            cellPicture.topAnchor.constraint(equalTo: self.cellContainer.topAnchor, constant: 11)
            ])
    }
    
    func setConstraintsCellSubPicture() {
        self.cellPicture.addSubview(cellSubPicture)
        NSLayoutConstraint.activate([
            cellSubPicture.widthAnchor.constraint(equalToConstant: 21),
            cellSubPicture.heightAnchor.constraint(equalToConstant: 40),
            cellSubPicture.centerXAnchor.constraint(equalTo: self.cellPicture.centerXAnchor),
            cellSubPicture.centerYAnchor.constraint(equalTo: self.cellPicture.centerYAnchor)
            ])
    }

}
