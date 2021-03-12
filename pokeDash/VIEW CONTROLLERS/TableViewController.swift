//
//  FirstViewController.swift
//  pokeDash
//
//  Created by Prism Student on 2020-02-27.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let fileName = "pokemonDB"
    let fileExt = "csv"
    @IBOutlet weak var tableImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //clear the sharedcollection
        let theSharedCollection = PokemonCollection()
        theSharedCollection.clearAll()
        
        tableView.delegate = self
        tableView.dataSource = self
        let setHeight = CGFloat(150) //change here for table height manual override
        tableView.rowHeight = setHeight;
        // read file add results to tableview
        setTable()
        let whichImg = Int.random(in: 0 ..< 3) // randomly pick background image
        switch whichImg{
            case 0:
                self.tableImage.image = UIImage(named: "blueBack")
            case 1:
                self.tableImage.image = UIImage(named: "redBack")
            case 2:
                self.tableImage.image = UIImage(named: "yellowBack")
            default:
                self.tableImage.image = UIImage(named: "yellowBack")
        }
        tableView.reloadData()
    }
    
    // read csv
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    // data preprocessing
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    // read file
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    // set table
    func setTable(){
        let theSharedCollection = PokemonCollection()
        // load csv data
        var data = readDataFromCSV(fileName: fileName, fileType: fileExt)
        data = cleanRows(file: data!)
        var csvRows = csv(data: data!)
        csvRows.removeFirst() // remove first row of headers, not needed
        
        // loop to add data to collection
        for(index, _) in csvRows.enumerated(){
            let name = csvRows[index][1]
            //let iname = name.lowercased()
            let type1 = csvRows[index][2]
            let type2 = csvRows[index][3]
            let moreInfo = csvRows[index][11]
                
            //print(name, type1, type2, moreInfo)
            theSharedCollection.add(pokemonName: name, type1: type1, type2: type2 , moreInfo: moreInfo)
        }
    }
    
    // reload data once user goes back to table
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theSharedCollection = PokemonCollection()
        theSharedCollection.setCurrentIndex(to: indexPath.row)
        performSegue(withIdentifier: "pokemonDetailView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return PokemonCollection.collection.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theSharedCollection = PokemonCollection()
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        theSharedCollection.setCurrentIndex(to: indexPath.row)
        cell.pokemonLabel.text = theSharedCollection.getName()
        //cell.pokemonImage.image = theSharedCollection.getImage()
        cell.pokemonImage.loadGif(name: theSharedCollection.getName().lowercased())
        return cell
    }
 
    @IBAction func backMenu(_ sender: Any){
        self.dismiss(animated: true)
        //self.performSegue(withIdentifier: "Table2Menu", sender: self)
    }
    
    @IBAction func toLeaderboard(_ sender: Any){
        self.performSegue(withIdentifier: "Table2Leaderboard", sender: self)
    }
}

