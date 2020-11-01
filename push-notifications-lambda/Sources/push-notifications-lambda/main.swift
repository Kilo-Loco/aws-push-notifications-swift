import AWSLambdaEvents
import AWSLambdaRuntime
import Foundation
import Pinpoint

let accessKeyId = ProcessInfo.processInfo.environment["AWS_ACCESS_KEY_ID"]
let secretAccessKey = ProcessInfo.processInfo.environment["AWS_SECRET_ACCESS_KEY"]
let pinpointApplicationId = ProcessInfo.processInfo.environment["PINPOINT_APPLICATION_ID"]
let pinpoint = Pinpoint(accessKeyId: accessKeyId, secretAccessKey: secretAccessKey, region: .uswest2)

Lambda.run { (context, event: DynamoDB.Event, completion: @escaping (Result<String, Error>) -> Void) in
    guard let applicationId = pinpointApplicationId else { return }
    
    for record in event.records {
        guard let event = record.change.newImage ?? record.change.oldImage else {
            completion(.failure(LambdaError.noImage))
            return
        }
        
        guard case .string(let deviceToken) = event["deviceToken"] else {
            completion(.failure(LambdaError.noDeviceToken))
            return
        }
        
        let message = Pinpoint.APNSMessage(
            body: "Welcome to the world of serverless",
            sound: "bingbong.aiff",
            title: "Hello Swift Lambda"
        )
        let messageConfig = Pinpoint.DirectMessageConfiguration(aPNSMessage: message)
        let messageRequest = Pinpoint.MessageRequest(
            addresses: [deviceToken: Pinpoint.AddressConfiguration(channelType: .apnsSandbox)],
            messageConfiguration: messageConfig
        )
        let request = Pinpoint.SendMessagesRequest(
            applicationId: applicationId,
            messageRequest: messageRequest
        )
        
        pinpoint.sendMessages(request).whenComplete { result in
            switch result {
            case .success:
                completion(.success("Sent push to \(deviceToken)"))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}

enum LambdaError: Error {
    case noDeviceToken
    case noImage
    case sendNotificationFailed
}
