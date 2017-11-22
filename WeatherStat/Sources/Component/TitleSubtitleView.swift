//
//  TitleSubtitleView.swift
//  WeatherStat
//
//  Created by Le Thanh Hai on 11/23/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import BonMot
import EasyPeasy

class TitleSubtitleModel {
    let title: String
    let subtitle: String
    
    let style: Style
    struct Style {
        let titleStyle: StringStyle
        let subtitleStyle: StringStyle
        init(titleStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopyRegular()),
                                                   .color(AppStyle.instance.colorDarkGray()),
                                                   .alignment(.center)),
             subtitleStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopyXLargeRegular()),
                                                      .color(AppStyle.instance.colorDarkGray()),
                                                      .alignment(.center))) {
            self.titleStyle = titleStyle
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
        self.subtitle = subtitle
        self.style = style
        self.padding = padding
    }
}

class TitleSubtitleView: BaseView {
    let labelTitle = UILabel()

    let labelSubtitle = UILabel()
    var padding = HourStatModel.Padding()
    override func configureSubviews() {
        super.configureSubviews()
        self.addSubview(self.labelTitle)
        self.addSubview(self.labelSubtitle)
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.labelTitle.easy.layout(
            Top(self.padding.appPadding.top),
            Left(self.padding.appPadding.left),
            Right(self.padding.appPadding.right)
        )
        
        self.labelSubtitle.easy.layout(
            Top(self.padding.verticalSpace).to(self.labelTitle),
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
        self.padding = model.padding
        self.configureLayout()
    }
}
