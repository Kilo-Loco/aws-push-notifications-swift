// swiftlint:disable all
import Amplify
import Foundation

public struct Notification: Model {
  public let id: String
  public var deviceToken: String
  
  public init(id: String = UUID().uuidString,
      deviceToken: String) {
      self.id = id
      self.deviceToken = deviceToken
  }
}