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
    
    //1 mentor 2 mentee
    
    private var networkManager: NetworkManager = .shared
    
    @IBOutlet var addPhotoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        loadPhoto()
        
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
    
    func loadPhoto() {
        networkManager.getPhotoTemp(id: 2, token: token) { image in
           print(image)
            
            
            if let imageData = Data(base64Encoded: image.data, options: .ignoreUnknownCharacters) {
                self.profileImageView.image = UIImage(data: imageData)
                print(imageData)
            }
            
        }
        
//        let data = Data(base64Encoded: "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCABAAEADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+iiopp1gALg4PcUJXAloqut7A/Rqk+0Rf38fUYp2YrklFRfaIi2A2foM0vnR5wXAPoeKLMdySikDK3RgfoaWkAVma0+y1B9606x/EJIskx13VUdxPYp2zl1GVyParjvkx43KWUAnjPU+tZdr9zkVad9ph7jaOD9TWjJMnTNS+26C15qFqLuWCeZNkEIZmKsF+Vc9cGtJdetreFUOm6pFGP8ApxchRn2z61z+kmKOwmD25lA1S8C44x84rpYZBPHH5R8lyf4o2fPt1GKTVwFk1jTBLLE9ysTxOY2M0bRru54DMAG6djWxZ824+p/nWJHeyeV5cqyZxyy4x+RY1s6ec2i5OTk8n60pbDW5arE8SNi1jA/vf4Vt15/8TfFcPhlNOWW0kuftRfAjmEZXbg55Bz1pU4uUrLcJSUVeWxp2eMYLLj2rQKwtGjPjgAZ3ds14sPi3aRNkaHcH63i//E1KPjVAoH/EknGP+nxP/iK39hU7fkZqtTfU9A8P+W+m3LhA6nUrtlB/3x61src7GVvs06KByFjU5/EGvMvD3jS4/sTTYbTSDc3F891c4a8SMIPO28krz0qw3izWJHQroSfOQqn+04iOTjqU4qOR/wBNF8y/pM9GW4jIKrbThevEWB/OtrSz/omB2YivH4/GmqRoZ/7GhKDg/wDE1hHP/fI/WvRfAWvjxFoEt59m+zMly8LxecsuCoH8S8d6mUXa/wCqGpK9jdl02GYcy3S/7lzIv8mrJvvBOh6p5f8AaVu995efL+1yGUpnGcFs46CuhorNSa2HZHI/8Kx8H/8AQDtP+/K/4Up+GXg8qQdDtMEY4iUfyFdbRT55dwsjlE+G3hJLaG2/saCSGAMIll+fYGYsQC2SOSTTh8N/Bw/5l6wP1hFdTRRzS7hZHNL8PfCC/wDMu6cfrAprY03SNP0aBoNNs4rWFm3GOJdq59cdKu0UnJvdhZH/2Q==", options: .ignoreUnknownCharacters)
//        profileImageView.image = UIImage(data: data!)
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        print("tapped")
        self.showAlert()
        
        guard let image = profileImageView.image else { return }
        
        let uploader = ImageUploader(uploadImage: image, number: 1)
        uploader.uploadImage(token: token) { result in
            switch result {
            case .success(let response):
//                    NotificationCenter.default.post(name: "ProfileEdited", object: nil)
                print("SUCCESS!")
            case .failure(let failure):
                print(failure)
            }
        }
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
            self?.schoolTextLabel.text = person.school
            self?.universityTextLabel.text = person.university
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
