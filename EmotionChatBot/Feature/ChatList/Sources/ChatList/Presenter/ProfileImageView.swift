//
//  ProfileImageView.swift
//  
//
//  Created by kimchansoo on 2023/11/09.
//

import UIKit

import RxSwift
import Kingfisher

public final class ProfileImageView: UIImageView {
    
    // MARK: - UI
    
    // MARK: - Properties
    
    // MARK: - Initializer
    public init() {
        super.init(frame: .zero)
        
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
//        self.backgroundColor = .gray
//        self.backgroundColor = UIColor(red: 88, green: 95, blue: 240, alpha: 1)
        // background color를 #585FF0로 설정
        self.backgroundColor = UIColor(red: 88/255, green: 95/255, blue: 240/255, alpha: 1)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius = self.frame.height / 2
        self.layer.cornerRadius = cornerRadius
    }
    
    public func setImage(at profileImageURL: URL?) {
        let maxProfileImageSize = CGSize(width: 80, height: 80)
        let downsamplingProcessor = DownsamplingImageProcessor(size: maxProfileImageSize)
        // asset에 있는 robot을 기본 이미지로 넣어준다.
        self.kf.setImage(with: profileImageURL, placeholder: UIImage(named: "robot"), options: [.processor(downsamplingProcessor)])
    }
}

public extension Reactive where Base: ProfileImageView {
    var setImage: Binder<URL?> {
        return Binder(self.base) { imageView, url in
            let downsamplingProcessor = DownsamplingImageProcessor(size: imageView.frame.size)
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "robot"),options: [.processor(downsamplingProcessor)])
        }
    }
}

