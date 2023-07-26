//
//  NameViewController.swift
//  Race
//
//  Created by Никита Суровцев on 26.07.23.
//

import UIKit

protocol NameInputDelegate: AnyObject {
    func nameInputDidFinish(_ name: String)
}

class NameInputViewController: UIViewController {

    weak var delegate: NameInputDelegate?
    let textField = UITextField()
    let cancelButton = UIButton()
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray2

        textField.placeholder = "Enter name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelInput), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)

        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveInput), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            cancelButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: textField.centerXAnchor, constant: -10),
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: textField.centerXAnchor, constant: 10)
        ])
    }

    @objc private func cancelInput() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func saveInput() {
        guard let name = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else {
            return
        }

        delegate?.nameInputDidFinish(name)
        dismiss(animated: true, completion: nil)
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


