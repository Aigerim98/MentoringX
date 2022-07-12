//
//  MainTabBarController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 12.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    var person: Person = Person(fullName: "Aigerim Abdurakhmanova", email: "aigerim@gmail.com", role: "Mentor", school: "NIS Almaty", phoneNumber: "234567890")
    
    var educations: [Education] = [Education(image: "uog.jpg", university: "University of Glasgow", major: "MSc Computer Systems Engineering", yearsOfStudy: "2021 - 2022"), Education(image: "kbtu.jpg", university: "KBTU", major: "BSc Automation and Control", yearsOfStudy: "2015 - 2019")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            
            if let profileViewController = viewController as? ProfileViewController {
                profileViewController.person = person
                profileViewController.educations = educations
            }
            
            if let newsViewController = viewController as? NewsViewController {
                newsViewController.person = person
                newsViewController.education = educations
            }
        }
    }
    

}
