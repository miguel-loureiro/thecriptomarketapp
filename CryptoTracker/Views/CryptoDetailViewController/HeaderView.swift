/*
 HeaderView.swift
 
 Displays the data from a single Ticker.
 
 Created by Cristina Dobson
 */


import Foundation
import UIKit


class HeaderView: UIView {
  
  
  // MARK: - Properties
  
  var imageView: UIImageView!
  var nameLabel: UILabel!
  var priceLabel: UILabel!
  var changeLabel: UILabel!
  
  
  // MARK: - View Model
  
  var viewModel: HeaderViewModel? {
    didSet {
      setupViews()
    }
  }
  
  func setupViews() {
    nameLabel.text = viewModel?.name
    imageView.image = viewModel?.getImage()
    priceLabel.text = viewModel?.getPriceString()
    
    let changeString = viewModel?.getPricePercentageChangeString()
    changeLabel.text = changeString
    changeLabel.textColor = ColorHelper.getPercentageLabelColor(
      for: changeString!)
  }
  
  
  // MARK: - Init Methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    addViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  func setupView() {
    backgroundColor = .clear
  }
  
  func addViews() {

    /*
     Icon Image View
     */
    imageView = getImageView()
    addSubview(imageView)
    
    
    /*
     Name Label
     */
    nameLabel = getLabel(
      color: .white, text: "", fontSize: 20, weight: .semibold)
    addSubview(nameLabel)
    
    // Name Label + Icon Stack
    let titleIconStack = getStackView(axis: .horizontal, spacing: 12)
    addSubview(titleIconStack)
    titleIconStack.addArrangedSubview(imageView)
    titleIconStack.addArrangedSubview(nameLabel)
    
    NSLayoutConstraint.activate([
      // ImageView
      imageView.heightAnchor.constraint(
        equalToConstant: 40),
      imageView.heightAnchor.constraint(
        equalTo: imageView.widthAnchor, multiplier: 1),
      
      // titleIconStack
      titleIconStack.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: 24),
      titleIconStack.centerYAnchor.constraint(
        equalTo: centerYAnchor)
    ])
    
    
    /*
     Data Labels Stack
     */
    
    // PriceLabelStack
    let priceLabelStack = getStackView(axis: .vertical, spacing: 2)
    
    priceLabel = getLabel(
      color: .white, text: "", fontSize: 17, weight: .medium)
    
    let priceSubtitleLabel = getLabel(
      color: .darkGray,
      text: NSLocalizedString("Last Trade", comment: ""),
      fontSize: 14, weight: .medium)
    
    // Arrange Price labels on PriceLabelStack
    addSubview(priceLabel)
    addSubview(priceSubtitleLabel)
    addSubview(priceLabelStack)
    priceLabelStack.addArrangedSubview(priceLabel)
    priceLabelStack.addArrangedSubview(priceSubtitleLabel)
    
    // ChangeLabelStack
    let changeLabelStack = getStackView(axis: .vertical, spacing: 2)
    
    changeLabel = getLabel(
      color: .white, text: "", fontSize: 17, weight: .medium)
    
    let changeSubtitleLabel = getLabel(
      color: .darkGray,
      text: NSLocalizedString("24h Price", comment: ""),
      fontSize: 14, weight: .medium)
    
    // Arrange Percentage Change labels on ChangeLabelStack
    addSubview(changeLabel)
    addSubview(changeSubtitleLabel)
    addSubview(changeLabelStack)
    changeLabelStack.addArrangedSubview(changeLabel)
    changeLabelStack.addArrangedSubview(changeSubtitleLabel)
    
    // Arrange Price and Change label stacks into DataLabelsStack
    let dataLabelsStack = getStackView(axis: .horizontal, spacing: 12)
    addSubview(dataLabelsStack)
    dataLabelsStack.addArrangedSubview(priceLabelStack)
    dataLabelsStack.addArrangedSubview(changeLabelStack)
        
    NSLayoutConstraint.activate([
      // titleIconStack
      dataLabelsStack.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -24),
      dataLabelsStack.centerYAnchor.constraint(
        equalTo: centerYAnchor)
    ])
    
  }
  
  
  // MARK: - UI Helper Methods
  
  func getStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
    let stackView = ViewHelper.createStackView(
      axis, distribution: .fill)
    stackView.spacing = spacing
    return stackView
  }
  
  func getLabel(color: UIColor, text: String, fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
    let newLabel = ViewHelper.createLabel(
      with: color, text: text, alignment: .left,
      font: UIFont.systemFont(ofSize: fontSize, weight: weight))
    return newLabel
  }
  
  func getImageView() -> UIImageView {
    let newImageView = ViewHelper.createImageView()
    return newImageView
  }
  
}
