/*
 ColorHelper.swift
 
 Created by Cristina Dobson
 */


import UIKit


// MARK: - UIColor Extension

extension UIColor {
  
  static let backgroundBlue = UIColor(red: 10/255, green: 2/255, blue: 118/255, alpha: 1)
  
  static let backgroundPurple = UIColor(red: 93/255, green: 1/255, blue: 152/255, alpha: 1)
  
  static let darkestGray = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
  
  static let darkestGrayAlpha = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
  
  static let lighterGray = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
  
  static let infoButtonWhite = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
  
}


// MARK: - Color Helper

struct ColorHelper {
  
  /*
   Get the color of the label based on the negative
   or positive value of the amount
   */
  static func getPercentageLabelColor(for amount: String) -> UIColor {
    return amount.contains("-") ? .red : .green
  }
  
}







