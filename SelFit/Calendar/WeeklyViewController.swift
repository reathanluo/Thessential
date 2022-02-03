//
//  WeeklyViewController.swift
//  SelFit
//
//  Created by Ng Jun Heng on 28/1/22.
//

import UIKit


class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                            UITableViewDelegate, UITableViewDataSource
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let taskDAL: TaskDAL = TaskDAL()
    
    var thisDayTask:[CoreDataEvents] = []
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    

    var totalSquares = [Date]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setCellsView()
        setWeekView()
        
        
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2)
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView()
    {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: appDelegate.selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday)
        {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: appDelegate.selectedDate)
        + " " + CalendarHelper().yearString(date: appDelegate.selectedDate)
        collectionView.reloadData()
        self.tableView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == appDelegate.selectedDate)
        {
            cell.backgroundColor = UIColor.systemBlue
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let day = totalSquares[indexPath.item]
        appDelegate.selectedDate = day
        
        thisDayTask = []
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .full
        
        for e in taskDAL.retrieveAllEvents()
        {
            if (formatter.string(from: e.date) ==   formatter.string(from: appDelegate.selectedDate))
            {
                thisDayTask.append(e)
                print(e)
            }
        }
        
        collectionView.reloadData()
        self.tableView.reloadData()
        
    }
    
    @IBAction func previousWeek(_ sender: Any)
    {
        appDelegate.selectedDate = CalendarHelper().addDays(date: appDelegate.selectedDate, days: -7)
        setWeekView()
    }
    
    @IBAction func nextWeek(_ sender: Any)
    {
        appDelegate.selectedDate = CalendarHelper().addDays(date: appDelegate.selectedDate, days: 7)
        setWeekView()
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return thisDayTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
        let event:CoreDataEvents = thisDayTask[indexPath.row]
        cell.eventLabel.text = event.name + " " + CalendarHelper().timeString(date: event.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:
            UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == UITableViewCell.EditingStyle.delete {
                    let event = thisDayTask[indexPath.row]
                    taskDAL.deleteEvent(event: event)
                    self.tableView.reloadData()
                }
            }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.tableView.reloadData()
        setWeekView()
    }
}

