//
//  ProfileViewController.swift
//  ToDO
//
//  Created by t2023-m0096 on 2023/09/18.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    private let user: User
    
    private let userId = UILabel()
    private let userNameLabel = UILabel()
    private let titleLabel = UILabel()
    private let postLabel = UILabel()
    private let followerLabel = UILabel()
    private let followingLabel = UILabel()
    
    private let FeedcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitle("팔로잉", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .selected)
        button.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    @objc private func followButtonTapped() {
        followButton.isSelected = !followButton.isSelected
        if followButton.isSelected {
            followButton.setTitle("팔로잉", for: .selected)
            followButton.backgroundColor = .gray
        } else {
            followButton.backgroundColor = .systemBlue
            
        }
    }
    
    private let messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Message", for: .normal)
        return button
    }()
    
    private let toggleCollectionViewbutton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.down")
        button.setImage(image, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(toggleCollectionView), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    
    
    private var ViewHidden = false
    
    @objc private func toggleCollectionView() {
        ViewHidden.toggle()
        FeedcollectionView.isHidden = ViewHidden
        toggleCollectionViewbutton.transform = ViewHidden ? .identity : CGAffineTransform(rotationAngle: .pi)
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Image1")
        iconImageView.layer.cornerRadius = 50
        iconImageView.clipsToBounds = true
        self.view.addSubview(iconImageView)
        
        userId.text = user.username
        userId.textAlignment = .center
        userId.font = UIFont.boldSystemFont(ofSize: 21)
        view.addSubview(userId)
        
        userNameLabel.text = user.username
        userNameLabel.textAlignment = .center
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(userNameLabel)
        
        postLabel.text = "\(user.postCount)\nPost"
        postLabel.numberOfLines = 2
        postLabel.textAlignment = .center
        
        followerLabel.text = "\(user.followersCount) \nfollowers"
        followerLabel.numberOfLines = 2
        followerLabel.textAlignment = .center
        
        followingLabel.text = "\(user.followingCount) \nfollowing"
        followingLabel.numberOfLines = 2
        followingLabel.textAlignment = .center
        
        view.addSubview(postLabel)
        view.addSubview(followerLabel)
        view.addSubview(followingLabel)
        view.addSubview(followButton)
        view.addSubview(followingButton)
        view.addSubview(FeedcollectionView)
        view.addSubview(toggleCollectionViewbutton)
        
        
        titleLabel.text = "IOS Developer"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(titleLabel)
        
        userId.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(75)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.bottom.equalTo(userNameLabel).offset(-60)
            $0.width.height.equalTo(100)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(-14)
            $0.leading.equalTo(iconImageView)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(-20)
            
        }
        
        postLabel.snp.makeConstraints {
            $0.centerX.equalTo(iconImageView.snp.trailing).offset(50)
            $0.centerY.equalTo(iconImageView.snp.bottom).inset(50)
        }
        
        followerLabel.snp.makeConstraints {
            $0.centerX.equalTo(postLabel.snp.trailing).offset(55)
            $0.centerY.equalTo(iconImageView.snp.bottom).inset(50)
            
            
        }
        
        followingLabel.snp.makeConstraints {
            $0.centerX.equalTo(followerLabel.snp.trailing).offset(55)
            $0.centerY.equalTo(iconImageView.snp.bottom).inset(50)
        }
        followButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
            $0.width.equalTo(155)
            $0.height.equalTo(35)
        }
        followingButton.snp.makeConstraints{
            $0.top.equalTo(followButton)
            $0.trailing.equalTo(followButton.snp.trailing).offset(170)
            $0.width.equalTo(155)
            $0.height.equalTo(35)
            
        }
        toggleCollectionViewbutton.snp.makeConstraints {
            $0.top.equalTo(followingButton)
            $0.trailing.equalTo(followingButton).offset(40)
            $0.width.equalTo(35)
            $0.height.equalTo(35)
        }
        
    
        FeedcollectionView.snp.makeConstraints {
            $0.top.equalTo(followButton.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        FeedcollectionView.collectionViewLayout = createLayout()
        FeedcollectionView.register(ProfileViewCell.self, forCellWithReuseIdentifier: ProfileViewCell.identifier)
        FeedcollectionView.dataSource = self
        FeedcollectionView.delegate = self
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ colletionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.FeedDataAr.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileViewCell.identifier, for: indexPath) as? ProfileViewCell else {
            return UICollectionViewCell()
        }
        let FeedData = user.FeedDataAr[indexPath.item]
        cell.ProfileImageView.image = FeedData.FeedImage
        
        
        return cell
    }
}
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (UIScreen.main.bounds.width - 10 * 4) / 3 - 2
        layout.itemSize = CGSize(width: width, height: width)
        
        return layout
    }
}
