//
//  AddNewTaskViewController.swift
//  TODO App
//
//  Created by Darek on 15/10/2021.
//

import UIKit

protocol AddNewTaskViewControllerProtocol: AnyObject {
    func showNewTaskSavedAlert()
}

class AddNewTaskViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: AddNewTaskViewControllerProtocol?
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Anuluj", for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura", size: 20)
        button.setTitleColor(.appGreen, for: .normal)
        button.addTarget(self, action: #selector(handlerBackToHome), for: .touchUpInside)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.appGreen.cgColor
        button.layer.cornerRadius = 20
        
       return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dodaj nowe zadanie", for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handlerAddTask), for: .touchUpInside)
        button.backgroundColor = .appGreen
        button.layer.cornerRadius = 20
        
       return button
    }()

    private lazy var nameViewContainer: UIView = {
        let view = TaskDetailsViewContainer(title: "Nazwa zadania", bgColor: .orange, textField: taskNameTextField)
        return view
    }()
    
    private lazy var dateViewContainer: UIView = {
        let view = TaskDetailsViewContainer(title: "Data wykonania", bgColor: .blue, dataPickerView: taskFinishDatePicker)
        return view
    }()
    
    private lazy var categoryViewContainer: UIView = {
        let view = TaskDetailsViewContainer(title: "Kategoria", bgColor: .purple, pickerView: taskCategoryPicker)
        return view
    }()
    
    private let taskNameTextField: UITextField = {
       let textFiled = UITextField()
        textFiled.placeholder = "Podaj nazwę zadania"
        return textFiled
    }()
    
    private let taskCategoryPicker: UIPickerView = UIPickerView()
    private let taskFinishDatePicker: UIDatePicker = UIDatePicker()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .appLightBlue
        self.title = "Dodaj nowe zadanie:"
        self.navigationItem.hidesBackButton = true
        taskCategoryPicker.delegate = self
        taskCategoryPicker.dataSource = self
        configureButtonsUI()
        configureTaskDetailsUI()
    }
    
    //MARK: - UI Helper Functions
    private func configureButtonsUI(){
        view.addSubview(backButton)
        backButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingRight: 10,height: 50)
        
        view.addSubview(saveButton)
        saveButton.anchor(left: view.leftAnchor, bottom: backButton.topAnchor, right: view.rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, height: 50)
    }
    
    private func configureTaskDetailsUI(){
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: saveButton.topAnchor, right: view.rightAnchor, paddingBottom: 20)
        
        let stack = UIStackView(arrangedSubviews: [nameViewContainer, dateViewContainer, categoryViewContainer])
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.axis = .vertical
        
        scrollView.addSubview(stack)
        stack.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor,paddingTop: 20,height: 450)
        stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
    }
    
    
    // MARK: - Selectors
    @objc func handlerBackToHome(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handlerAddTask(){
        print("Add task:")
        saveNewTaskToDB()
        print(Category.allCases[taskCategoryPicker.selectedRow(inComponent: 0)])
    }
    
//    @objc func handlerShowNewTaskSavedAlert(){
//        //delegate?.showNewTaskSavedAlert()
//    }

    //MARK: - CoreData
   private func saveNewTaskToDB(){
       guard let title:String = taskNameTextField.text else {return}
       if Validation.shared.validateTaskTitle(title: title) == false {
           self.noTitleTextErrorAlert()
           return
       }
       
       let category = Category.init(rawValue: taskCategoryPicker.selectedRow(inComponent: 0))
       guard let category = category else {
           return
       }

       let task = TaskModel(title: title, addedDate: Date(), finishDate: taskFinishDatePicker.date, category: category)
        
       CoreDataService.shared.saveData(task: task) { err in
            if err != nil {
                print("Error saving data")
                self.savingErrorAlert()
                return
            }
            //No errors - task saved, back to home
            self.delegate?.showNewTaskSavedAlert()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - Alerts
    private func savingErrorAlert(){
        let alert = UIAlertController(title: "Bład podczas zapisu", message: "Wystąpił błąd podczas dodawania zadania do bazy danych.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Spróbuj ponownie", style: .default, handler: { _ in
            self.saveNewTaskToDB()
        }))
        alert.addAction(UIAlertAction(title: "Anuluj", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
 
        self.present(alert, animated: true)
    }
    
    private func noTitleTextErrorAlert(){
        let alert = UIAlertController(title: "Uzupełnij nazwe zadania", message: "Nazwa zadania musi zawierać chociaż 1 znak a maksymalnie 40 znaków", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 
        self.present(alert, animated: true)
    }
}

extension AddNewTaskViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        if let categoryName: String = Category(rawValue: row)?.description {
            pickerLabel.text = categoryName
        }
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 15)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
}
