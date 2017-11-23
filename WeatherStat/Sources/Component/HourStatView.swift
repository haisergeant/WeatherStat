//
//  HourStatView.swift
//  WeatherStat
//
//  Created by Le Thanh Hai on 11/23/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import BonMot
import EasyPeasy

class HourStatModel {
    let title: String
    let image: UIImage?
    let subtitle: String
    
    let style: Style
    struct Style {
        let titleStyle: StringStyle
        let imageSize: CGSize
        let imageColor: UIColor
        let subtitleStyle: StringStyle
        init(titleStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopySmallRegular()),
                                                   .color(AppStyle.instance.colorDarkGray()),
                                                   .alignment(.center)),
             imageSize: CGSize = AppStyle.instance.sizeImageSmall(),
             imageColor: UIColor = AppStyle.instance.colorLightBlue(),
             subtitleStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopyRegular()),
                                                      .color(AppStyle.instance.colorDarkGray()),
                                                      .alignment(.center))) {
            self.titleStyle = titleStyle
            self.imageSize = imageSize
            self.imageColor = imageColor
            self.subtitleStyle = subtitleStyle
        }
    }
    
    let padding: Padding
    struct Padding {
        let appPadding: AppPadding
        let verticalSpace: CGFloat
        init(appPadding: AppPadding = AppPadding(left: 10, right: 10, top: 8, bottom: 8),
             verticalSpace: CGFloat = 4) {
            self.appPadding = appPadding
            self.verticalSpace = verticalSpace
        }
    }
    
    init(title: String,
         image: UIImage? = nil,
         subtitle: String,
         style: Style = Style(),
         padding: Padding = Padding()) {
        self.title = title
        self.image = image
        self.subtitle = subtitle
        self.style = style
        self.padding = padding
    }
}

class HourStatView: BaseView {
    let labelTitle = UILabel()
    let imageView = UIImageView()
    let labelSubtitle = UILabel()
    var padding = HourStatModel.Padding()
    override func configureSubviews() {
        super.configureSubviews()
        self.addSubview(self.labelTitle)
        self.addSubview(self.imageView)
        self.addSubview(self.labelSubtitle)
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.labelTitle.easy.layout(
            Top(self.padding.appPadding.top),
            CenterX().with(.high),
            Left(self.padding.appPadding.left).with(.low),
            Right(self.padding.appPadding.right).with(.low)
        )
        
        self.imageView.easy.layout(
            Top(self.padding.verticalSpace).to(self.labelTitle),
            CenterX().with(.high),
            Left(self.padding.appPadding.left).with(.low),
            Right(self.padding.appPadding.right).with(.low)
        )
        
        self.labelSubtitle.easy.layout(
            Top(self.padding.verticalSpace).to(self.imageView),
            Left(self.padding.appPadding.left),
            Right(self.padding.appPadding.right),
            Bottom(self.padding.appPadding.bottom)
        )
        self.labelTitle.setContentCompressionResistancePriority(.required, for: .vertical)
        self.labelSubtitle.setContentCompressionResistancePriority(.required, for: .vertical)
        self.imageView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    override func configureContent() {
        super.configureContent()
    }
    
    func configure(model: HourStatModel) {
        self.labelTitle.attributedText = model.title.styled(with: model.style.titleStyle)
        self.labelSubtitle.attributedText = model.subtitle.styled(with: model.style.subtitleStyle)
        self.imageView.image = model.image?.brush(withColor: model.style.imageColor)
        self.imageView.contentMode = .scaleAspectFit
        
        self.imageView.easy.layout(Size(model.style.imageSize))
        self.padding = model.padding
        self.configureLayout()
    }
}

class HourListModel {
    var models: [HourStatModel]
    init(models: [HourStatModel]) {
        self.models = models
    }
}

class HourListView: BaseView {
    let scrollView = UIScrollView()
    let container = UIView()
    
    let topSeparator = UIView()
    let bottomSeparator = UIView()
    
    override func configureSubviews() {
        super.configureSubviews()
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.container)
        
        self.addSubview(self.topSeparator)
        self.addSubview(self.bottomSeparator)
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.scrollView.easy.layout(
            Top(),
            Bottom(),
            Left(20),
            Right(20),
            Height().like(self.container)
        )
        
        self.container.easy.layout(
            Top(),
            Bottom(),
            Left(),
            Right()
        )
        
        self.topSeparator.easy.layout(
            Top(),
            Left(),
            Right(),
            Height(1)
        )
        
        self.bottomSeparator.easy.layout(
            Bottom(),
            Left(),
            Right(),
            Height(1)
        )
    }
    
    override func configureStyle() {
        super.configureStyle()
        self.topSeparator.backgroundColor = AppStyle.instance.colorPaleGray()
        self.bottomSeparator.backgroundColor = AppStyle.instance.colorPaleGray()
        
        self.backgroundColor = .white
        self.scrollView.clipsToBounds = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
    }
    
    func configure(model: HourListModel) {
        let models = model.models
        self.container.subviews.forEach { $0.removeFromSuperview() }
        
        var prev: HourStatView? = nil
        models.forEach { model in
            let view = HourStatView()
            view.configure(model: model)
            self.container.addSubview(view)
            if let prev = prev {
                view.easy.layout(
                    Top(),
                    Bottom(),
                    Left().to(prev, .right)
                )
            } else {
                view.easy.layout(
                    Top(),
                    Bottom(),
                    Left()
                )
            }
            prev = view
        }
        
        if let prev = prev {
            prev.easy.layout(Right())
        }
    }
}

class HourListViewCell: BaseTableViewCell {
    let listView = HourListView()
    init() {
        super.init(identifier: "HourListViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        self.contentView.addSubview(self.listView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.listView.easy.layout(Edges())
    }
    
    func configure(model: HourListModel) {
        self.listView.configure(model: model)
    }
}
