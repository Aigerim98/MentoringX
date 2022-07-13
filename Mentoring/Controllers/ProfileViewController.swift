//
//  ProfileViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import UIKit
import HCSStarRatingView

class ProfileViewController: UIViewController {

    var person: Person!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var schoolTextLabel: UILabel!
    @IBOutlet var universityTextLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var starRating: HCSStarRatingView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundView: UIView!
    
    private var majors: [String] = ["Math", "Informatics", "Physics"]
    
    var educations: [Education] = []
    var token: String!
    
    
    private var networkManager: NetworkManager = .shared
    
    @IBOutlet var addPhotoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        starRating.value = 4.5
        
        schoolTextLabel.text = "NIS Almaty"
        universityTextLabel.text = "BSc Kazakh - British Technical University, MSc University of Glasgow"
          
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 75
        
//        addPhotoView.layer.cornerRadius = 20.5
//        addPhotoView.backgroundColor = UIColor(red: 117/255, green: 239/255, blue: 164/255, alpha: 1)
//
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        gradientView()
        
       // navigationController?.setNavigationBarHidden(false, animated: true)
//        stackView.removeAllArrangedSubviews()
//        for education in educations {
//            let educationView = EducationView()
//            education.configure(with: education)
//            stack
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func loadData() {
        networkManager.getUserName(token: token!) { [weak self] name in
            print("name \(name)")
            self?.fullNameLabel.text = name
        }
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        print("tapped")
        self.showAlert()
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
        vc.token = token
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.backgroundView.bounds
        gradientLayer.colors = [UIColor(red: 117/255, green: 239/255, blue: 164/255, alpha: 1).cgColor, UIColor.white.cgColor]
        self.backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController

           (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
    
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension ProfileViewController: UserInfoDelegate {
    func getUserInfo() {
        networkManager.getUserInfo(token: token) { [weak self] person in
            print(person)
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func showAlert() {

        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

           if UIImagePickerController.isSourceTypeAvailable(sourceType) {

               let imagePickerController = UIImagePickerController()
               imagePickerController.delegate = self
               imagePickerController.sourceType = sourceType
               self.present(imagePickerController, animated: true, completion: nil)
           }
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

           self.dismiss(animated: true) { [weak self] in

               guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
               //Setting image to your image view
               self?.profileImageView.image = image
           }
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        majors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: majors[indexPath.row])
        cell.layer.borderColor = UIColor(red: 117/255, green: 239/255, blue: 164/255, alpha: 1).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        cell.configure(with: educations[indexPath.row])
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        educations.count
    }
}
