/*
 PricesTableView.swift
 
 Displays the ASK and BID arrays.
 One array per PricesTableView instance.
 
 Created by Cristina Dobson
 */


import UIKit


class PricesTableView: UIView {
  
  
  // MARK: - Properties
  var tableView: UITableView!
  let cellID = "TableCell"
  let headerID = "TableHeader"
  
  
  // MARK: - View Model
  
  lazy var viewModel = {
    PriceTableViewModel()
  }()
  
  
  // MARK: - Init methods
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupTableView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  // MARK: - Setup Methods
  
  // Initialize the TableView
  func setupTableView() {
    
    tableView = UITableView(frame: frame, style: .plain)
    tableView.backgroundColor = .black
    
    // Delegates
    tableView.delegate = self
    tableView.dataSource = self
    
    // Register the TableView's cell and header
    tableView.register(PricesTableCell.self, forCellReuseIdentifier: cellID)
    
    // TableView style
    tableView.bounces = false
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
    tableView.contentInset.top = 8
    tableView.contentInset.bottom = 24
    
    // Add TableView to current view
    addSubview(tableView)
  }
  
  
  // MARK: - Reload TableView
  
  // Reload TableView
  func reloadViewModel(with array: [CryptoPrice], for pricesType: PriceType) {
    viewModel.setupViewModel(with: array, for: pricesType)
    tableView.reloadData()
  }
  
}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension PricesTableView: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.priceCellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PricesTableCell
    
    let cellViewModel = viewModel.getCellViewModel(at: indexPath)
    cell.cellViewModel = cellViewModel
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
}














