

import Foundation
import UIKit

class Limonade : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    weak var tableView:UITableView!
    let container:TableContainer
    
    private var registeredNibCells:Array<String>
    private var cellConfigurator:((_ cell:UITableViewCell, _ model:AnyObject?, _ nameRow:String, _ nameSection:String)->())?
    private var handlerSelectCell:((_ model:AnyObject?, _ cell:UITableViewCell?, _ nameRow:String, _ nameSection:String)->())?
    private var handlerDidScrool:((UIScrollView)->())?
    private var handlerDidEndDragging:((UIScrollView)->())?
    private var handlerDidEndDecelerating:((UIScrollView)->())?
    private var headerConfigurator:((_ header:UIView, _ nameSection:String)->())?
    
    required init(tableView:UITableView){
        self.tableView = tableView
        container = TableContainer(threadsafe: false)
        registeredNibCells = Array<String>()
        
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    deinit {
        
    }
    
    public func appendSection(name:String, sortKey:String? = nil){
    
        guard self.container.item(id: name) == nil else  {
            fatalError("section exist")
        }
        
        let section:Section = Section(id: name, sortKey:sortKey)
        container.add(item: section)
    }
    
    public func appendSection(name:String, headerView:UIView, sortKey:String? = nil){
        
        guard self.container.item(id: name) == nil else  {
            fatalError("section exist")
        }
        
        let section:Section = Section(id: name, sortKey: sortKey, header:Header(viewHeader: headerView))
        container.add(item: section)
    }
    
    public func isExistSection(name:String) -> Bool{
        return self.container.item(id: name) != nil ? true : false
    }
    
    public func appendRow(name:String,
                   data:AnyObject?,
                   nameCell:String,
                   indexSection:Int){
        
        let row:Row = Row(id: name, sortKey: nil, model: data, cell: Cell(reuseId: nameCell, nibName: nameCell))
        let section = container.item(index: indexSection) as! Section
        section.add(item: row)
        self.registerCellIfNeeded(nameNib: nameCell, reuseId: nameCell)
    }
    
    public func appendRow(name:String,
                   data:AnyObject?,
                   nameCell:String,
                   nameSection:String,
                   sortKey:String? = nil){
        
        let row:Row = Row(id: name, sortKey: sortKey,  model: data, cell: Cell(reuseId: nameCell, nibName: nameCell))
        let section = container.item(id: nameSection) as! Section
        section.add(item: row)
        self.registerCellIfNeeded(nameNib: nameCell, reuseId: nameCell)
    }
    
    public func reloadRow(nameRow:String, nameSection:String){
  
        if let section:Section = self.container.item(id: nameSection) as? Section{
            let indexSection = self.container.index(item: section)
            if let row = section.item(id: nameRow) as? Row{
                let indexRow = section.index(item: row)
                if indexSection != nil && indexRow != nil {
                    
                    self.tableView.reloadRows(at: [IndexPath(item: indexRow!, section: indexSection!)], with: UITableView.RowAnimation.automatic)
                }
            }
        }
    }
    
    public func getVisibleCells() -> [UITableViewCell]{
        return self.tableView.visibleCells
    }
    
    public func clearAll(){
        self.container.removeAll()
    }
    
    public func isEmpty() -> Bool{
        if self.container.count()  > 0 {
            return false
        }
        else {
            return true
        }
    }
    
    public func setHandlerConfigureCell(handler:@escaping (_ cell:UITableViewCell, _ model:AnyObject?, _ nameRow:String, _ nameSection:String)->()){
        self.cellConfigurator = handler
    }
    
    public func setHandlerSelectCell(handler:@escaping (_ model:AnyObject?,_ cell:UITableViewCell?, _ nameRow:String, _ nameSection:String)->()){
        self.handlerSelectCell = handler
    }
    
    public func setHandlerConfigureHeader(handler:@escaping (_ header:UIView, _ nameSection:String)->()){
        self.headerConfigurator = handler
    }
    
    public func setHandlerDidScrooll(handler:@escaping (UIScrollView)->()){
        self.handlerDidScrool = handler
    }
    
    public func setHandlerDidEndDragging(handler:@escaping (UIScrollView)->()){
        self.handlerDidEndDragging = handler
    }
    
    public func setHandlerDidEndDecelerating(handler:@escaping (UIScrollView)->()){
        self.handlerDidEndDecelerating = handler
    }
    
    private func registerCellIfNeeded(nameNib:String, reuseId:String){
        
        guard self.registeredNibCells.contains(nameNib) == false else {
            return
        }
        
        self.tableView.register(UINib(nibName:nameNib, bundle:nil), forCellReuseIdentifier: reuseId)
        self.registeredNibCells.append(nameNib)
    }
    
    
    //MARK: - UITabBarDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.container.item(index:section) as! IContainer).count()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return container.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section:Section = self.container.item(index: indexPath.section) as! Section
        let row:Row = section.item(index: indexPath.row) as! Row
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cell.reuseId, for: indexPath)
        self.cellConfigurator?(cell, row.model, row.id, section.id)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section:Section = self.container.item(index: section) as! Section
        let header = section.header?.viewHeader
        
        if header != nil {
            self.headerConfigurator?(header!, section.id)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let section:Section = self.container.item(index: section) as! Section
        var height:CGFloat = 0.00001
        
        if section.header?.viewHeader != nil {
            height = section.header!.viewHeader!.frame.size.height
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section:Section = self.container.item(index: indexPath.section) as! Section
        let row:Row = section.item(index: indexPath.row) as! Row
        let cell = tableView.cellForRow(at: indexPath)
        self.handlerSelectCell?(row.model, cell, row.id, section.id)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.handlerDidScrool?(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.handlerDidEndDragging?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.handlerDidEndDecelerating?(scrollView)
    }
}
