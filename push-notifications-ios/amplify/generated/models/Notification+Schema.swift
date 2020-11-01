// swiftlint:disable all
import Amplify
import Foundation

extension Notification {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case deviceToken
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let notification = Notification.keys
    
    model.pluralName = "Notifications"
    
    model.fields(
      .id(),
      .field(notification.deviceToken, is: .required, ofType: .string)
    )
    }
}