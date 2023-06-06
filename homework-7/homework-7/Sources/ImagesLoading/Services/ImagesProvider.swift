//
//  DataProvider.swift
//  homework7
//
//  Created by 1okmon on 27.05.2023.
//

import Foundation

private enum Metrics {
    static let sessionIdentifier = "ImagesLoadingSession"
}
final class ImagesProvider: NSObject, IImagesProvider {
    static let shared: IImagesProvider = ImagesProvider()
    var onProgress: ((Float, UUID) -> Void)?
    var completion: ((URL, UUID) -> Void)?
    private var tasks: [UUID: URLSessionDownloadTask]
    private var tasksState: [UUID: (paused: Bool, url: URL, resumeData: Data?)]
    private var session: URLSession?
    
    override init() {
        self.tasks = [UUID: URLSessionDownloadTask]()
        self.tasksState = [UUID: (paused: Bool, url: URL, resumeData: Data)]()
        super.init()
        let config = URLSessionConfiguration.background(withIdentifier: Metrics.sessionIdentifier)
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    func download(with imageId: UUID, from url: URL) {
        guard let session = session else { return }
        let task: URLSessionDownloadTask
        let resumeData = tasksState[imageId]?.resumeData
        if let resumeData = resumeData {
            task = session.downloadTask(withResumeData: resumeData)
        } else {
            task = session.downloadTask(with: url)
        }
        task.resume()
        tasksState.updateValue((paused: false, url: url, resumeData: resumeData), forKey: imageId)
        tasks.updateValue(task, forKey: imageId)
    }
    
    func switchPause(with imageId: UUID) {
        guard let taskState = tasksState[imageId] else { return }
        if taskState.paused {
            resumeDownload(with: imageId)
        } else {
            pauseDownload(with: imageId)
        }
    }
}

private extension ImagesProvider {
    func pauseDownload(with imageId: UUID) {
        guard let state = tasksState[imageId] else { return }
        guard let task = tasks[imageId] else { return }
        task.cancel { [weak self] resumeDataOrNil in
            self?.tasksState.updateValue((paused: true, url: state.url, resumeData: resumeDataOrNil), forKey: imageId)
        }
    }
    
    func resumeDownload(with imageId: UUID) {
        guard let state = tasksState[imageId] else { return }
        self.download(with: imageId, from: state.url)
        tasksState.updateValue((paused: false, url: state.url, resumeData: state.resumeData), forKey: imageId)
    }
}

extension ImagesProvider: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let imageId = tasks.first(where: { $1 == downloadTask })?.key else { return }
        completion?(location, imageId)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        let progress = Float(Float(totalBytesWritten) / Float(totalBytesExpectedToWrite))
        guard let imageId = tasks.first(where: { $1 == downloadTask })?.key else { return }
        self.onProgress?(progress, imageId)
    }
}
