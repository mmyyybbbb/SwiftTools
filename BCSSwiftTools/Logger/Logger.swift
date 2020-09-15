//
//  Logger.swift
//  SwiftTools
//
//  Created by alexej_ne on 28.10.2019.
//  Copyright © 2019 alexeyne. All rights reserved.
//

import Foundation

public protocol LoggerDelegate: class {
    func didRecieveLog(log: Logger.Log, logger: Logger)
}

public final class Logger {
     
    /// Бизнесовая область приложения
    public struct Scope: Equatable {
        public let name: String
        
        public init(_ name: String) {
            self.name = name 
        }
        
        public static let empty = Scope(.empty)
    }
    
    public typealias AditionalParams = [String: Any]
  
    public struct Analytic {
        public let name: String
        public let params: AditionalParams
        public let tags: [Tag]
        public let source: String?
        public let description: String?
        
        public init(name: String, params: AditionalParams, tags: [Tag] = [], source: String?, description: String?) {
            self.name = name
            self.params = params
            self.source = source
            self.description = description
            self.tags = tags
        }
    }
    
    public enum Event {
        /// Неожидаемое поведение соответсвует fatalError
        case unexpected(String)
        /// Запись для систем аналитики
        case analytic(Analytic)
        /// Любая ошибка
        case error(Error)
        /// Справочкная информация
        case info(String)
        /// Информация для дебага
        case debug(String)
        /// Крошки
        case breadCrumb(String)
    }
    
    public enum Tag {
        case online
    }
    
    public struct Log {
        public let event: Event
        public let scope: Scope
        public let params: AditionalParams
        public let file: String
        public let function: String
        public let line: UInt
        public var callInfo: String { "\(function) [\(file) \(line)]" }
        
        public init(event: Event, scope: Scope, params: AditionalParams, file: String = #file, function: String = #function, line: UInt = #line) {
            self.event = event
            self.scope = scope
            self.params = params
            self.file = file
            self.function = function
            self.line = line 
        }
    }
    
    public weak var delegate: LoggerDelegate?
    
    public static let shared = Logger(name: "Shared")
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public func log(_ event: Event, scope: Scope = .empty, params: AditionalParams = [:], file: String = #file, function: String = #function, line: UInt = #line) {
        var params = params
        if case let .analytic(data) = event, params.isEmpty {
            params = data.params
        }
        let log = Log(event: event, scope: scope, params: params, file: file, function: function, line: line)
        self.log(log)
    }
    
    public func unexpected(_ message: String, scope: Scope = .empty, params: AditionalParams = [:], file: String = #file, function: String = #function, line: UInt = #line) {
        log(.unexpected(message), scope: scope, params: params, file: file, function: function, line: line)
    }
    
    public func analytic(_ analytic: Analytic, scope: Scope = .empty, params: AditionalParams = [:], file: String = #file, function: String = #function, line: UInt = #line) {
        log(.analytic(analytic), scope: scope, params: params, file: file, function: function, line: line)
    }
    
    public func error(_ error: Error, scope: Scope = .empty, params: AditionalParams = [:], file: String = #file, function: String = #function, line: UInt = #line) {
        log(.error(error), scope: scope, params: params, file: file, function: function, line: line)
    }
    
    public func debug(_ message: String, scope: Scope = .empty, params: AditionalParams = [:], file: String = #file, function: String = #function, line: UInt = #line) {
        log(.debug(message), scope: scope, params: params, file: file, function: function, line: line)
    }
 
    public func info(_ message: String, scope: Scope = .empty, params: AditionalParams = [:], file: String = #file, function: String = #function, line: UInt = #line) {
        log(.info(message), scope: scope, params: params, file: file, function: function, line: line)
    }
    
    public func breadCrumb(_ name: String, scope: Scope = .empty, params: AditionalParams = [:], file: String = #file, function: String = #function, line: UInt = #line) {
        log(.breadCrumb(name), scope: scope, params: params, file: file, function: function, line: line)
    }
    
    public func log(_ log: Log) {
        delegate?.didRecieveLog(log: log, logger: self)
    }
}

extension Logger.Log {
    public var text: String {
        
        func string(_ emoji: String, _ str: String) -> String {
            "\(emoji) [\(scope.name)] \(str) \(params.descriptionString)"
        }
        
        switch event {
        case .analytic(let analityc): return string("🔍", analityc.name)
        case .error(let error): return string("⚠️", "\(error)")
        case .unexpected(let message): return string("⛔", message)
        case .info(let message): return string("ℹ️", message)
        case .debug(let message): return string("🗜️", message)
        case .breadCrumb(let crumb): return string("👣", crumb)
        }
    }
}
 

