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
    let image: UIImage
    let subtitle: String
    
    let style: Style
    struct Style {
        let titleStyle: StringStyle
        let imageSize: CGSize
        let imageColor: UIColor
        let subtitleStyle: StringStyle
        init(titleStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopySmallRegular()),
                                                   .color(AppStyle.instance.colorDarkGray())),
             imageSize: CGSize = AppStyle.instance.sizeImageSmall(),
             imageColor: UIColor = AppStyle.instance.colorLightBlue(),
             subtitleStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopyRegular()),
                                                      .color(AppStyle.instance.colorDarkGray()))) {
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
        init(appPadding: AppPadding = AppPadding(left: 3, right: 3, top: 3, bottom: 3),
             verticalSpace: CGFloat = 4) {
            self.appPadding = appPadding
            self.verticalSpace = verticalSpace
        }
    }
    
    init(title: String,
         image: UIImage,
         subtitle: String,
         style: Style,
         padding: Padding) {
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
            Left(self.padding.appPadding.left),
            Right(self.padding.appPadding.right)
        )
        
        self.imageView.easy.layout(
            Top(self.padding.verticalSpace).to(self.labelTitle),
            Left(self.padding.appPadding.left),
            Right(self.padding.appPadding.right)
        )
        
        self.labelSubtitle.easy.layout(
            Top(self.padding.verticalSpace).to(self.imageView),
            Left(self.padding.appPadding.left),
            Right(self.padding.appPadding.right),
            Bottom(self.padding.appPadding.bottom)
        )
    }
    
    override func configureContent() {
        super.configureContent()
    }
    
    func configure(model: HourStatModel) {
        self.labelTitle.attributedText = model.title.styled(with: model.style.titleStyle)
        self.labelSubtitle.attributedText = model.subtitle.styled(with: model.style.subtitleStyle)
        self.imageView.image = model.image.brush(withColor: model.style.imageColor)
        
        self.imageView.easy.layout(Size(model.style.imageSize))
        self.padding = model.padding
        self.configureLayout()
    }
}
