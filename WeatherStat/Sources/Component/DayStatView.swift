//
//  DayStatView.swift
//  WeatherStat
//
//  Created by Hai Le Thanh on 11/23/17.
//  Copyright © 2017 haile. All rights reserved.
//

import UIKit
import BonMot
import EasyPeasy

class DayStatModel {
    let title: String
    let image: UIImage?
    let tempHigh: String
    let tempLow: String
    
    let style: Style
    struct Style {
        let titleStyle: StringStyle
        let imageSize: CGSize
        let imageColor: UIColor
        let tempHighStyle: StringStyle
        let tempLowStyle: StringStyle
        init(titleStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopySmallRegular()),
                                                   .color(AppStyle.instance.colorDarkGray())),
             imageSize: CGSize = AppStyle.instance.sizeImageSmall(),
             imageColor: UIColor = AppStyle.instance.colorLightBlue(),
             tempHighStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopyRegular()),
                                                      .color(AppStyle.instance.colorDarkGray()),
                                                      .alignment(.center)),
             tempLowStyle: StringStyle = StringStyle(.font(AppStyle.instance.fontBodyCopyRegular()),
                                                     .color(AppStyle.instance.colorLightGray()),
                                                     .alignment(.center))) {
            self.titleStyle = titleStyle
            self.imageSize = imageSize
            self.imageColor = imageColor
            self.tempHighStyle = tempHighStyle
            self.tempLowStyle = tempLowStyle
        }
    }
    
    let padding: Padding
    struct Padding {
        let appPadding: AppPadding
        let horizontalSpacing: CGFloat
        init(appPadding: AppPadding = AppPadding(left: 20, right: 20, top: 10, bottom: 10),
             horizontalSpacing: CGFloat = 5) {
            self.appPadding = appPadding
            self.horizontalSpacing = horizontalSpacing
        }
    }
    
    init(title: String,
         image: UIImage? = nil,
         tempHigh: String,
         tempLow: String,
         style: Style = Style(),
         padding: Padding = Padding()) {
        self.title = title
        self.image = image
        self.tempHigh = tempHigh
        self.tempLow = tempLow
        self.style = style
        self.padding = padding
    }
}

class DayStatView: BaseView {
    let labelTitle = UILabel()
    let imageView = UIImageView()
    let labelHighTemp = UILabel()
    let labelLowTemp = UILabel()
    override func configureSubviews() {
        super.configureSubviews()
        self.addSubview(self.labelTitle)
        self.labelTitle.numberOfLines = 0
        self.addSubview(self.imageView)
        self.addSubview(self.labelHighTemp)
        self.labelHighTemp.numberOfLines = 0
        self.addSubview(self.labelLowTemp)
        self.labelLowTemp.numberOfLines = 0
    }
    
    var padding = DayStatModel.Padding()
    
    override func configureLayout() {
        super.configureLayout()
        self.labelLowTemp.easy.layout(
            Top(self.padding.appPadding.top),
            Right(self.padding.appPadding.right),
            Bottom(<=self.padding.appPadding.bottom),
            Width(30.0)
        )
        
        self.labelHighTemp.easy.layout(
            Top(self.padding.appPadding.top),
            Right(self.padding.horizontalSpacing).to(self.labelLowTemp, .left),
            Bottom(<=self.padding.appPadding.bottom),
            Width(30.0)
        )
        
        self.imageView.easy.layout(
            Top(self.padding.appPadding.top),
            Right(self.padding.horizontalSpacing * 3).to(self.labelHighTemp, .left),
            Bottom(<=self.padding.appPadding.bottom)
        )
        
        self.labelTitle.easy.layout(
            CenterY(),
            Right(>=self.padding.horizontalSpacing).to(self.imageView, .left),
            Left(self.padding.appPadding.left)
        )
        
        self.labelTitle.setContentCompressionResistancePriority(.required, for: .vertical)
        self.labelLowTemp.setContentCompressionResistancePriority(.required, for: .vertical)
        self.labelHighTemp.setContentCompressionResistancePriority(.required, for: .vertical)
        self.imageView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    override func configureContent() {
        super.configureContent()
    }
    
    func configure(model: DayStatModel) {
        self.labelLowTemp.attributedText = model.tempLow.styled(with: model.style.tempLowStyle)
        self.labelHighTemp.attributedText = model.tempHigh.styled(with: model.style.tempHighStyle)
        self.imageView.image = model.image?.brush(withColor: model.style.imageColor)
        self.imageView.easy.layout(Size(model.style.imageSize))
        self.labelTitle.attributedText = model.title.styled(with: model.style.titleStyle)
        
        self.padding = model.padding
        self.configureLayout()
    }
}

class DayStatViewCell: BaseTableViewCell {
    let statView = DayStatView()
    
    init() {
        super.init(identifier: "DayStatViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        self.contentView.addSubview(self.statView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        self.statView.easy.layout(
            Edges()
        )
        self.statView.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func configure(model: DayStatModel) {
        self.statView.configure(model: model)
    }
}
