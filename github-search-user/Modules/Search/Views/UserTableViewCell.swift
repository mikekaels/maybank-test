//
//  UserTableViewCell.swift
//  github-search-user
//
//  Created by Santo Michael Sihombing on 20/11/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    let background: UIView = UIView()
        .configure { v in
            v.layer.cornerRadius = 10
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let image: UIImageView = UIImageView()
        .configure { v in
            v.image = UIImage(systemName: "person.fill")
            v.contentMode = .scaleAspectFill
            v.layer.cornerRadius = 25
            v.layer.masksToBounds = true
            v.heightAnchor.constraint(equalToConstant: 50).isActive = true
            v.widthAnchor.constraint(equalToConstant: 50).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let usernameLabel: UILabel = UILabel()
        .configure { v in
            v.text = "Kevin"
            v.textColor = .label
            v.textAlignment = .left
            v.lineBreakMode = .byWordWrapping
//            v.numberOfLines = 0
            v.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let githubIDLabel: UILabel = UILabel()
        .configure { v in
            v.text = "20247383"
            v.textColor = .label
            v.textAlignment = .left
            v.lineBreakMode = .byWordWrapping
//            v.numberOfLines = 0
            v.font = UIFont.systemFont(ofSize: 12, weight: .light)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let chevron: UIImageView = UIImageView()
        .configure { v in
            v.image = UIImage(systemName: "chevron.right")
            v.tintColor = .systemGray4
            v.widthAnchor.constraint(equalToConstant: 10).isActive = true
            v.translatesAutoresizingMaskIntoConstraints = false
        }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // background
        addSubview(background)
        background.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/3.7).isActive = true
        background.heightAnchor.constraint(equalToConstant: 60).isActive = true
        background.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
         // image
        background.addSubview(image)
        image.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10).isActive = true
        // username label
        background.addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 5).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        background.addSubview(githubIDLabel)
        githubIDLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -5).isActive = true
        githubIDLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        githubIDLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10).isActive = true
        githubIDLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        background.addSubview(chevron)
        chevron.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        chevron.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -15).isActive = true
    }

}
