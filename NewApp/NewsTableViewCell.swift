//
//  NewsTableViewCell.swift
//  NewApp
//
//  Created by Shivam Maheshwari on 24/05/23.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL?
    var imageData: Data? = nil
    
    init(title: String,
         subtitle: String,
         imageUrl: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let newTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newTitleLabel.frame = CGRect(origin: .init(x: 10,
                                                   y: 0),
                                     size: .init(width: contentView.frame.size.width - 170,
                                                 height: 70))
        
        subtitleLabel.frame = CGRect(origin: .init(x: 10,
                                                   y: 70),
                                     size: .init(width: contentView.frame.size.width - 170,
                                                 height: contentView.frame.size.height/2))
        
        newsImageView.frame = CGRect(origin: .init(x: contentView.frame.size.width - 150,
                                                   y: 5),
                                     size: .init(width: 140,
                                                 height: contentView.frame.size.height - 10))


    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageUrl {
            //download the image
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
