
import UIKit
import CoreData

class ViewController: UIViewController {

  // MARK: - Properties
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
  }()
  
  var managedContext: NSManagedObjectContext!

  var currentDog: Dog?

  // MARK: - IBOutlets
  @IBOutlet var tableView: UITableView!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    let dogName = "Halpert"
    let dogFetch: NSFetchRequest<Dog> = Dog.fetchRequest()
    dogFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Dog.name), dogName)
    
    do {
      let results = try managedContext.fetch(dogFetch)
      if results.count > 0 {
        currentDog = results.first
      } else {
        currentDog = Dog(context: managedContext)
        currentDog?.name = dogName
        try managedContext.save()
      }
    } catch let error as NSError {
      print("Fetch error: \(error) description: \(error.userInfo)")
    }
  }
}

// MARK: - IBActions
extension ViewController {

  @IBAction func add(_ sender: UIBarButtonItem) {
    
    let walk = Walk(context: managedContext)
    walk.date = NSDate()
    
    currentDog?.addToWalks(walk)
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Save error: \(error) description: \(error.userInfo)")
    }
    
    tableView.reloadData()
  }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentDog?.walks?.count ?? 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    guard let walk = currentDog?.walks?[indexPath.row] as? Walk,
          let walkDate = walk.date as Date? else {
        return cell
    }
    
    cell.textLabel?.text = dateFormatter.string(from: walkDate)
    return cell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "List of Walks"
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard let walkToRemove = currentDog?.walks?[indexPath.row] as? Walk,
          editingStyle == .delete else {
      return
    }
    
    managedContext.delete(walkToRemove)
    
    do {
      try managedContext.save()
      
      tableView.deleteRows(at: [indexPath], with: .automatic)
    } catch let error as NSError {
      print("Save error: \(error) description: \(error.userInfo)")
    }
  }
}
