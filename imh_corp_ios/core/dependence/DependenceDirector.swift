
import Foundation
import Cocaine

class DependenceDirector : IDependenceDirector{
    
    private let cocaine:I_Cocaine
    
    required init() {
        cocaine = Cocaine()
        registerAssemblys()
    }
    
    func tryInject<T>() -> T? {
        return cocaine.injector.tryInject()
    }
    
    func tryRegister(assembly:I_Assembly) throws{
         try cocaine.register.tryRegister(assembly:assembly)
    }
    
    private func registerAssemblys(){
        guard let assemblysList:NSArray = self.getListAssemblys() else {
            return
        }
        
        for recordAboutAssemblyItem in assemblysList{
            if let typeClass:String = recordAboutAssemblyItem as? String{
                let loadAssemblyType:AssemblyProviderImpl.Type? = NSClassFromString(typeClass) as? AssemblyProviderImpl.Type
                
                if loadAssemblyType != nil {
                    
                    let asseblyProvider = loadAssemblyType!.init()
                    cocaine.subscribe(provider: asseblyProvider, key: loadAssemblyType!.buildType())
                }
            }
        }

    }
    
    private func getListAssemblys() -> NSArray?{
        if let path = Bundle.main.path(forResource: "AssemblyList", ofType: "plist") {
            return NSArray(contentsOfFile: path)
        }
        else {
            return nil
        }
    }
}
