import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let manager = RealmManager.shared
    var isFavorite = false
    
    var cars = [RealmCar]() {
        didSet {
            filteredCars = cars
        }
    }
    
    var filteredCars = [RealmCar]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        return tableView
    }()
    
    lazy var brandTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "insert brand "
        return textfield
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    lazy var likeButton: UIButton = {
       let button = UIButton()
        let favImage = UIImage(systemName: "star.fill")?.withTintColor(.yellow)
        let defaultImage = UIImage(systemName: "star")?.withTintColor(.yellow)
        button.setImage(favImage, for: .selected)
        button.setImage(defaultImage, for: .normal)
        button.addTarget(self, action: #selector(filterTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        self.cars = manager.getCars()
        setupViews()
//        manager.deleteCars()
    }
    
    private func setupViews() {
        view.addSubviews(tableView, brandTextField, saveButton, likeButton)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        brandTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(brandTextField.snp.bottom).inset(12)
            make.height.equalTo(40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
            make.centerY.equalTo(brandTextField)
            make.leading.equalTo(brandTextField.snp.trailing).offset(8)
        }
        
    }
    
    @objc func saveAction() {
        manager.createCar(brand: brandTextField.text ?? "", color: "red", type: "sedan", isFavorite: false)
        self.cars = manager.getCars()
        
    }
    
    @objc func filterTapped(_ sender: UIButton) {
//        cars = cars.filter{$0.isFavorite == true}
        isFavorite.toggle()
        sender.isSelected.toggle()
//        switch isFavorite {
//        case true:
//            cars = cars.filter{$0.isFavorite == true}
//        case false:
//            cars = manager.getCars()
//        }
        
        if isFavorite {
            filteredCars = cars.filter({ $0.isFavorite })
        }else {
            filteredCars = cars
        }
    }
    
    private func deleteCar(_ car: RealmCar) {
        manager.deleteCars(car: car)
        self.cars = manager.getCars()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configure(filteredCars[indexPath.row])
        
        cell.likeAction = { [self] selected in
            manager.updateCar(car: filteredCars[indexPath.row], isFavorite: selected)
            self.cars = manager.getCars()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionContext = UIContextualAction(style: .destructive, title: "Delete") { actionContext, view, completion in
            self.deleteCar(self.filteredCars[indexPath.row])
            completion(true)
            
        }
        let actions = UISwipeActionsConfiguration(actions: [actionContext])
        return actions
    }
}
