//
//  AddEditViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    
    var viewModel: AddEditViewModel?
    weak var coordinator: AddEditCoordinator?
    
    lazy var pickerViewBrands: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else {return}
        viewModel.delegate = self
        
        title = viewModel.title
        btAddEdit.setTitle(viewModel.buttonTitle, for: .normal)
        tfBrand.text = viewModel.brand
        tfName.text = viewModel.name
        tfPrice.text = viewModel.price
        scGasType.selectedSegmentIndex = viewModel.gasType
        
        setupBrands()
        loadBrands()
    }
    
    func loadBrands() {
        viewModel?.loadBrands()
    }
    
    func setupBrands() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: view, action: #selector(UIView.endEditing))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.items = [btCancel, btSpace, btDone]
        tfBrand.inputAccessoryView = toolbar
        tfBrand.inputView = pickerViewBrands
    }
    
    @objc func done() {
        tfBrand.text = viewModel?.getBrandAt(pickerViewBrands.selectedRow(inComponent: 0))
        tfBrand.resignFirstResponder()
    }
    
    @IBAction func addEdit(_ sender: UIButton) {
        viewModel?.refreshCar(name: tfName.text.🧨, brand: tfBrand.text.🧨, gasType: scGasType.selectedSegmentIndex, price: tfPrice.text.🧨)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("AddEditViewController deinit")
        coordinator?.childDidFinish(coordinator)
    }
}

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.brandsCount ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.getBrandAt(row)
    }
}

extension AddEditViewController: AddEditViewModelDelegate {
    func onCarCreated(result: Result<Bool, APIError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.goBack()
            case .failure:
                Alert.show(title: "Erro", message: "Falha ao cadastrar o carro", presenter: self)
            }
        }
    }
    
    func onCarUpdate(result: Result<Bool, APIError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.goBack()
            case .failure:
                Alert.show(title: "Erro", message: "Falha ao atualizar o carro", presenter: self)
            }
        }
    }
    
    func onBrandsLoaded(result: Result<Bool, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.pickerViewBrands.reloadAllComponents()
            case .failure:
                Alert.show(title: "Erro", message: "Erro ao carregar as marcas", presenter: self)
                self.tfBrand.inputAccessoryView = nil
                self.tfBrand.inputView = nil
            }
        }
    }
}
