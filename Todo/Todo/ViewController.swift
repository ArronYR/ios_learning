//
//  ViewController.swift
//  Todo
//
//  Created by YangRong on 15/8/13.
//  Copyright © 2015年 arron. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []
var filteredTodos: [TodoModel] = []

func dateFromString(dateStr: String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.dateFromString(dateStr)
    return date
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化Todo list数据
        todos = [TodoModel(id: "1", image: "child-selected", title: "1. 去游乐场", date: dateFromString("2014-10-20")!),
            TodoModel(id: "2", image: "shopping-cart-selected", title: "2. 购物", date: dateFromString("2014-10-28")!),
            TodoModel(id: "3", image: "phone-selected", title: "3. 打电话", date: dateFromString("2014-10-30")!),
            TodoModel(id: "4", image: "travel-selected", title: "4. Travel to Europe", date: dateFromString("2014-10-31")!)]
        
        // 设置顶部左边编辑按钮
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // hide the search bar
        var contentOffset = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            return filteredTodos.count
        }
        else {
            return todos.count
        }
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell!
        
        // var todo = todos[indexPath.row] as TodoModel
        var todo : TodoModel
        
        if tableView == searchDisplayController?.searchResultsTableView {
            todo = filteredTodos[indexPath.row] as TodoModel
        }
        else {
            todo = todos[indexPath.row] as TodoModel
        }
        
        var image = cell.viewWithTag(101) as! UIImageView
        var title = cell.viewWithTag(102) as! UILabel
        var date = cell.viewWithTag(103) as! UILabel
        
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        let locale = NSLocale.currentLocale()
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        date.text = dateFormatter.stringFromDate(todo.date)
        
        return cell
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
            // 删除后快速刷新
            // self.tableView.reloadData()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    // set mode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    // Move the cell
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    // MARK - UISearchDisplayDelegate
    // Search the Cell
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        //filteredTodos = todos.filter({( todo: TodoModel) -> Bool in
        //    let stringMatch = todo.title.rangeOfString(searchString)
        //    return stringMatch != nil
        //})
        
        // Same as below
        filteredTodos = todos.filter(){$0.title.rangeOfString(searchString) != nil}
        return true
    }
    
    // MARK - Storyboard stuff
    // Unwind
    @IBAction func close(segue: UIStoryboardSegue) {
        print("closed!")
    }
    
    // Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditTodo" {
            var vc = segue.destinationViewController as! DetailViewController
            var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            // var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
        }
    }
}

