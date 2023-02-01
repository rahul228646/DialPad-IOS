
import UIKit

class ViewController: UIViewController {
    
    let dialPadModel = DialpadModel()
    
    private let phoneNumberLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 32, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dialpad : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.layer.borderWidth = 2
//        collectionView.layer.borderColor = UIColor.label.cgColor
        return collectionView
        
    }()
    

    
    private let deleteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "delete.left.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let dialButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "phone.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(phoneNumberLabel)
        view.addSubview(dialpad)
        view.addSubview(dialButton)
        view.addSubview(deleteButton)
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        dialpad.frame = view.bounds
        dialpad.delegate = self
        dialpad.dataSource = self
        configLayout()
    }
    
    func configLayout() {
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dialpad.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height*0.2),
            dialpad.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dialpad.heightAnchor.constraint(equalToConstant: view.frame.height*0.5),
            dialpad.widthAnchor.constraint(equalToConstant: view.frame.width*0.8),
            
            dialButton.topAnchor.constraint(equalTo: dialpad.bottomAnchor, constant: dialpad.frame.height*0.01),
            dialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dialButton.heightAnchor.constraint(equalToConstant: 90),
            dialButton.widthAnchor.constraint(equalToConstant:90),
            
            deleteButton.topAnchor.constraint(equalTo:  dialpad.bottomAnchor, constant: dialpad.frame.height*0.01),
            deleteButton.heightAnchor.constraint(equalToConstant: 90),
            deleteButton.widthAnchor.constraint(equalToConstant:90),
            deleteButton.leftAnchor.constraint(equalTo: dialButton.rightAnchor, constant: 20)
            
        ])
    }
    @objc func onClick() {
        
        guard let text = phoneNumberLabel.text else {return}
        
        if text.count == 0 {
            deleteButton.isHidden = true
        }
        else {
            phoneNumberLabel.text = String(text.dropLast())
            if phoneNumberLabel.text?.count == 0 {
                deleteButton.isHidden = true
            }
        }
    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return view.frame.width*0.01
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.frame.height*0.01
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.backgroundColor = UIColor.systemGray4.cgColor
        cell.layer.cornerRadius = cell.frame.width/2
        dialButton.layer.cornerRadius = cell.frame.width/2
        deleteButton.layer.cornerRadius = cell.frame.width/2
        let num = dialPadModel.getNum()
        let alt = dialPadModel.getAlt()
        let index = indexPath.row
        cell.delegate = self
        cell.dialpadLabelNumber.text = num[index]
        cell.dialpadLabelAlpha.text = alt[index]
        
        return cell
    }
    

}

extension ViewController : CollectionViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewCell, number: String?) {
        guard let num = number else {return}
        if num >= "0" && num <= "9" {
            phoneNumberLabel.text! += num
            deleteButton.isHidden = false
        }
        else if num == "+" {
            phoneNumberLabel.text! += num
            deleteButton.isHidden = false
        }
        
        
    }
    
}


