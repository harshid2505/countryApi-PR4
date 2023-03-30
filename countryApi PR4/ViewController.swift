//
//  ViewController.swift
//  countryApi PR4
//
//  Created by HARSHID PATEL on 24/03/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    
    
    var arr: [WelcomeElement] = []
    var arr2: [WelcomeElement] = []
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryDataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        let url = URL(string: "https://restcountries.com/v3.1/all")
        var ur = URLRequest(url: url!)
        ur.httpMethod = "GET"
        URLSession.shared.dataTask(with: ur) { [self] data, response, error in
            do{
                if error == nil{
                    arr = try JSONDecoder().decode([WelcomeElement].self, from: data!)
                    arr2 = arr
                    DispatchQueue.main.async {
                        countryDataTableView.reloadData()
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryDataTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.lb1.text = arr[indexPath.row].name.common
        cell.lb2.text = arr[indexPath.row].name.official
        cell.img.image = stringToImg(link: arr[indexPath.row].flags.png)
        
        return cell
    }
    
    func stringToImg(link:String)->UIImage{
        let url1 = URL(string: link)
        let data = try? Data(contentsOf: url1! as URL)
        
        return UIImage(data: data!)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigation(photo: stringToImg(link: arr[indexPath.row].flags.png), name1: arr[indexPath.row].name.common,population: arr[indexPath.row].population,photo2: stringToImg(link: arr[indexPath.row].coatOfArms.png!))
    }
    
    func navigation(photo:UIImage,name1:String,population:Int,photo2:UIImage){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        navigate.c = photo
        navigate.a = name1
        navigate.b = population
        navigate.d = photo2
        navigationController?.pushViewController(navigate, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""{
            arr = arr2
        }
        else{
            arr = arr2.filter({ i in
                i.name.common.contains(searchBar.text!)
            })
        }
        countryDataTableView.reloadData()
    }
}

