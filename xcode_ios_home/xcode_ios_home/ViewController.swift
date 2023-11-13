//
//  ViewController.swift
//  xcode_ios_home
//
//  Created by Rezo on 09.10.2023.
//

import UIKit

final class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterData.count
    }
    
    //СОЗДАНИЕ ЯЧЕЙКИ
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characterData[indexPath.row]
        var cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = character.name
        configuration.secondaryText = character.quote
        cell.contentConfiguration = configuration
        return cell
    }
    
    
// СОЗДАЕМ ТАБЛИЧКУ, В КОТОРУЮ БУДЕМ КЛАСТЬ НАШИ ДАННЫЕ
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        //ЗДЕСЬ БУДЕМ ЗАДАВАТЬ КАКИЕ-ТО ДЕФОЛТНЫЕ ЗНАЧЕНИЯ-ПАРАМЕТРЫ ДЛЯ ТАБЛИЦЫ
        tableView.backgroundColor = .yellow
        tableView.dataSource = self
        return tableView
    }()
    
    private var characterData: [CharacterDTO] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        //ДОБАВЛЯЕМ ТАБЛИЧКУ
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //Задаем границы для таблицы
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        //ЗАПРОС ДАННЫХ
        let url: URL = URL(string: "https://gravity-falls-api.vercel.app/api/characters")!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            //Обработка данных
            self.characterData = try! decoder.decode([CharacterDTO].self, from: data)
            //ОБНОВЛЯЕМ ТАБЛИЧКУ
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
        }).resume()
    }
}

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
//    let imageUrl: URL
    let quote: String
}
