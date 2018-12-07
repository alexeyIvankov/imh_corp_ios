

import Foundation
import UIKit

class Limonade : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    weak var tableView:UITableView!
    let container:TableContainer
    
    private var registeredNibCells:Array<String>
    
    private var handlerCreateCellFoRow:((
    _ cell:UITableViewCell,
    _ model:AnyObject?,
    _ nameRow:String,
    _ nameSection:String)->())?
    
    private var handlerWillDisplayCellFoRow:((
    _ cell:UITableViewCell,
    _ model:AnyObject?,
    _ nameRow:String,
    _ nameSection:String,
    _ sectionPosition:Int,
    _ rowPosition:Int,
    _ countSections:Int,
    _ countRows:Int)->())?
    
    private var handlerSelectCell:((
    _ model:AnyObject?,
    _ cell:UITableViewCell?,
    _ nameRow:String,
    _ nameSection:String)->())?
    
    private var handlerCreateHeaderViewFoSection:((
    _ header:UIView,
    _ model:AnyObject?)->())?
    
    private var handlerDidScrool:((
    UIScrollView)->())?
    
    private var handlerDidEndDragging:((
    UIScrollView)->())?
    
    private var handlerDidEndDecelerating:((
    UIScrollView)->())?
 
    
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
    
    public func appendSectionIfNeed(item:ILimonadeItem,
                                    animation: UITableView.RowAnimation,
                                    header:String?=nil,
                                    sortType:SortItemType = .ascending){
        
        guard self.container.item(id: item.limonadeId) == nil else  {
            return
        }
        
        if header != nil {
            let section:Section = Section(id: item.limonadeId, sortKey: item.limonadeSortKey, sortType:sortType, model:item, header:Header(viewHeader:  Bundle.loadView(name:header!)))
            container.add(item: section)
        }
        else {
            let section:Section = Section(id: item.limonadeId, sortKey: item.limonadeSortKey,sortType:sortType, model:item)
            container.add(item: section)
        }
        self.addSectionAnimate(sectionItem: item, animation: animation)
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
    
    public func tryAppendOrUpdateRow(rowItem:ILimonadeItem,
                                     sectionItem:ILimonadeItem, 
                                     nameCell:String,
                                     animation: UITableView.RowAnimation){
        guard let section:Section = container.item(id: sectionItem.limonadeId) as? Section else {
            return
        }
        
        var row = section.item(id: rowItem.limonadeId) as? Row
        
        if row == nil{
            row = Row(id: rowItem.limonadeId, sortKey: rowItem.limonadeSortKey,  model: rowItem as AnyObject, cell: Cell(reuseId: nameCell, nibName: nameCell))
            section.add(item: row!)
            self.registerCellIfNeeded(nameNib: nameCell, reuseId: nameCell)
            self.addRowAnimate(rowItem: rowItem, sectionItem: sectionItem, animation: animation)
        }
        else {
            if let currentModel:ILimonadeItem = row?.model as? ILimonadeItem{
                if currentModel.getHashLimonade() != rowItem.getHashLimonade(){
                    row?.model = rowItem
                    self.reloadRow(rowItem: rowItem, sectionItem: sectionItem, animation: animation)
                }
                else {
                    print("skip update!!")
                }
            }
        }
        
        
    }
    
    public func reloadRow(nameRow:String,
                          nameSection:String,
                          animation:UITableView.RowAnimation){
        
        if let section:Section = self.container.item(id: nameSection) as? Section{
            let indexSection = self.container.index(item: section)
            if let row = section.item(id: nameRow) as? Row{
                let indexRow = section.index(item: row)
                if indexSection != nil && indexRow != nil {
                    self.tableView.reloadRows(at: [IndexPath(item: indexRow!, section: indexSection!)], with:animation)
                }
            }
        }
    }
    
    public func reloadRow(rowItem:ILimonadeItem,
                          sectionItem:ILimonadeItem,
                          animation:UITableView.RowAnimation){
        
        if let section:Section = self.container.item(id: sectionItem.limonadeId) as? Section{
            let indexSection = self.container.index(item: section)
            if let row = section.item(id: rowItem.limonadeId) as? Row{
                let indexRow = section.index(item: row)
                if indexSection != nil && indexRow != nil {
                    self.tableView.beginUpdates()
                    self.tableView.reloadRows(at: [IndexPath(item: indexRow!, section: indexSection!)], with:animation)
                    self.tableView.endUpdates()
                }
            }
        }
    }
    
    
    public func addRowAnimate(rowItem:ILimonadeItem,
                              sectionItem:ILimonadeItem,
                              animation:UITableView.RowAnimation){
        
        if let section:Section = self.container.item(id: sectionItem.limonadeId) as? Section{
            let indexSection = self.container.index(item: section)
            if let row = section.item(id: rowItem.limonadeId) as? Row{
                let indexRow = section.index(item: row)
                if indexSection != nil && indexRow != nil {
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: [IndexPath(item: indexRow!, section: indexSection!)], with: animation)
                    self.tableView.endUpdates()
                }
            }
        }
    }
    
    public func addSectionAnimate(sectionItem:ILimonadeItem,
                                  animation:UITableView.RowAnimation){
        
        if let section:Section = self.container.item(id: sectionItem.limonadeId) as? Section{
            let indexSection = self.container.index(item: section)
            if indexSection != nil{
                self.tableView.beginUpdates()
                self.tableView.insertSections([indexSection!], with: animation)
                self.tableView.endUpdates()
            }
        }
    }
    
    
    public func isExistSection(name:String) -> Bool{
        return self.container.item(id: name) != nil ? true : false
    }
    
    public func isExistRow(sectionName:String, rowId:String) -> Bool{
        guard let section:Section = self.container.item(id: sectionName) as? Section else{
            return false
        }
        
        if section.item(id: rowId) != nil{
            return true
        }
        else {
            return false
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
    
    public func getLastModelRowIn(sectionId:String) -> Any{
        let section:Section = self.container.item(id: sectionId) as! Section
        let row:Row = section.allItems().last as! Row
        return row.model
    }
    
    public func setHandlerCreateCellFoRow(handler:@escaping (
        _ cell:UITableViewCell,
        _ model:AnyObject?,
        _ nameRow:String,
        _ nameSection:String)->()){
        
        self.handlerCreateCellFoRow = handler
    }
    
    public func setHandlerWillDisplayCellFoRow(handler:@escaping (
        _ cell:UITableViewCell,
        _ model:AnyObject?,
        _ nameRow:String,
        _ nameSection:String,
        _ sectionPosition:Int,
        _ rowPosition:Int,
        _ countSections:Int,
        _ countRows:Int)->()){
        
        self.handlerWillDisplayCellFoRow = handler
    }
    
    public func setHandlerSelectCell(handler:@escaping (
        _ model:AnyObject?,
        _ cell:UITableViewCell?,
        _ nameRow:String,
        _ nameSection:String)->()){
        
        self.handlerSelectCell = handler
    }
    
    public func setHandlerCreateHeaderViewFoSection(handler:@escaping (
        _ header:UIView,
        _ model:AnyObject?)->()){
        
        self.handlerCreateHeaderViewFoSection = handler
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
    
    private func registerCellIfNeeded(nameNib:String,
                                      reuseId:String){
        
        guard self.registeredNibCells.contains(nameNib) == false else {
            return
        }
        
        self.tableView.register(UINib(nibName:nameNib, bundle:nil), forCellReuseIdentifier: reuseId)
        self.registeredNibCells.append(nameNib)
    }
    
    
    //MARK: - UITabBarDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return (self.container.item(index:section) as! IContainer).count()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return container.count()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section:Section = self.container.item(index: indexPath.section) as! Section
        let row:Row = section.item(index: indexPath.row) as! Row
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cell.reuseId, for: indexPath)
        self.handlerCreateCellFoRow?(cell, row.model, row.id, section.id)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        let section:Section = self.container.item(index: indexPath.section) as! Section
        let row:Row = section.item(index: indexPath.row) as! Row
        self.handlerWillDisplayCellFoRow?(cell,
                                          row.model,
                                          row.id,
                                          section.id,
                                          indexPath.section,
                                          indexPath.row,
                                          self.container.count(),
                                          section.count())
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section:Section = self.container.item(index: section) as! Section
        let header = section.header?.viewHeader
        
        if header != nil {
            
            if section.model != nil{
                self.handlerCreateHeaderViewFoSection?(header!, section.model)
            }
            else {
                self.handlerCreateHeaderViewFoSection?(header!, section.id as AnyObject)
            }
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        
        let section:Section = self.container.item(index: section) as! Section
        var height:CGFloat = 0.00001
        
        if section.header?.viewHeader != nil {
            height = section.header!.viewHeader!.frame.size.height
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
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
