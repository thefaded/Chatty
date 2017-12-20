//
//  UserCell.swift
//  Chatty
//
//  Created by Daniil on 20.12.17.
//  Copyright © 2017 thePODDUBSTEP. All rights reserved.
//
import UIKit
import Firebase

class UserCell: UITableViewCell {
    
    let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var message: Message? {
        didSet {
            setupNameAndProfileImage()

            detailTextLabel?.text = message?.text
            
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timestampDate)
            }
            
        }
    }
    
    private func setupNameAndProfileImage() {
        
        if let id = message?.chatPartnerId() {
            let ref = Database.database().reference().child("users").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.textLabel?.text = dictionary["name"] as? String
                    
                    if let profileImageUrl = dictionary["profileImageUrl"] as? String {
                        self.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
                    }
                }
                
            }, withCancel: nil)
        }
//        if let toId = message?.toId {
//            let ref = Database.database().reference().child("users").child(toId)
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                if let dictionary = snapshot.value as? [String: Any] {
//                    self.textLabel?.text = dictionary["name"] as? String
//                    if let profileImageUrl = dictionary["profileImageUrl"] as? String {
//                        self.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
//                    }
//                    //                    print(dictionary["name"])
//                }
//            }, withCancel: nil)
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(64, (textLabel?.frame.origin.y)! - 2, (textLabel?.frame.width)!, (textLabel?.frame.height)!)
        detailTextLabel?.frame = CGRect(64, (detailTextLabel?.frame.origin.y)! + 2, (detailTextLabel?.frame.width)!, (detailTextLabel?.frame.height)!)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nedstark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        addSubview(timeLabel)
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ////        dismiss(animated: true) {
    ////            print("Dismiss completed")
    ////            let user = self.users[indexPath.row]
    ////            self.messagesController?.showChatControllerForUser(user)
    ////        }
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
