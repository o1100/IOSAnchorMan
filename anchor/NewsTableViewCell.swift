//
//  NewsTableViewCell.swift
//  anchor
//
//  Created by Vincent Jin on 2022/6/21.
//

import UIKit

class NewsTableViewCellViewModel{
    let name: String
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(
        name: String,
        title: String,
        subtitle: String,
        imageURL: URL?
    ){
        self.name = name
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {
    
    
    static let identifier = "NewsTableViewCell"
    
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font =  .systemFont(ofSize: 25, weight: .medium)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let newsSourceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.systemBlue
        label.font =  .systemFont(ofSize: 15, weight: .medium)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font =  .systemFont(ofSize: 18, weight: .regular)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsSourceLabel)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(newsImageView)
        setupConstraints()
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    
    func setupConstraints() {
        newsSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            newsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -16),
            newsTitleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -25),
            
            //newsSourceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            newsSourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsSourceLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -16),
            //newsSourceLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -8),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -16),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            newsImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.33)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        newsSourceLabel.text = viewModel.name
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subtitle
     //image
        
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
            
        }else if let url = viewModel.imageURL {
                URLSession.shared.dataTask(with: url) {[weak self] data,_,error in
                guard let data = data, error == nil else{
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
