// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "0f312ab427e382a2cbd5ca034ecf8105"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Notification.self)
  }
}