import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static var cellIdentifier = "TableViewCell"
    
    var likeAction: ((Bool) -> ())?
    
    lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var likeButton: UIButton = {
       let button = UIButton()
        let favImage = UIImage(systemName: "star.fill")?.withTintColor(.yellow)
        let defaultImage = UIImage(systemName: "star")?.withTintColor(.yellow)
        button.setImage(favImage, for: .selected)
        button.setImage(defaultImage, for: .normal)
        button.addTarget(self, action: #selector(likeTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    func configure(_ car: RealmCar) {
        brandLabel.text = car.brand
        colorLabel.text = car.color
        likeButton.isSelected  = car.isFavorite
        typeLabel.text = car.type
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubviews(brandLabel, colorLabel, typeLabel, likeButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        brandLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
        }
        colorLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(4)
            make.leading.bottom.equalToSuperview().inset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
    }
    
    @objc func likeTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        likeAction?(sender.isSelected)
    }
    
}

