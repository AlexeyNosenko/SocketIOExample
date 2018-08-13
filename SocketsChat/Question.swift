//
//  Question.swift
//  SocketsChat
//
//  Created by Алексей on 20.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

// let swiftSocket = manager.socket(forNamespace: "/swift")
// default socket = socket(forNamespace: "/")
// разобрать логи по строкам
// привести папки как надо
// расставить комменты как надо
// создать подключение через два соккета либо через два spacename
// узнать сколько подключений может быть совершено к сокету
// on, onAny, emit, off, SocketIOClientOption(возможные параметры подключения), StarScream (WTF?)
// Передача файлов по сети
// залить презентацию и проект на гитхаб с описанием
//[.connectParams(["token": token])

/*
 ===== SocketManager ======= - мультиплексирование нескольких пространств именчерез один SocketEngineSpec
 
 public var defaultSocket: SocketIOClient {
 return socket(forNamespace: "/")
 }
 forceNew - позволяет обновлять URL, если она будет изменена во время работы, если true пересоздает engine
 engin: SocketEngineSpec - движок
 nsps = [String: SocketIOClient]()
 nsp - NameSpacing
 nsps - NameSpacings
 public var reconnects = true
 handleQueue - поток в котором происходит обработка очереди
 public var reconnectWait = 10
 
 currentReconnectAttempt = 0
 
 func emitAll(_ event: String, withItems items: [Any]) - отправляет сообщение всем клиентам
 
 open func socket(forNamespace nsp: String) -> SocketIOClien
 
 ====== status: SocketIOStatus ====
 case notConnected - The client/manager has never been connected. Or the client has been reset.
 case disconnected - The client/manager was once connected, but not anymore.
 case connecting - The client/manager is in the process of connecting.
 case connected - The client/manager is currently connected.
 
 private var _config: SocketIOClientConfiguration
 ===== SocketIOClientOption ======
 case compress - If given, the WebSocket transport will attempt to use compression.
 case connectParams([String: Any]) - A dictionary of GET parameters that will be included in the connect url.
 case cookies([HTTPCookie]) - An array of cookies that will be sent during the initial connection.
 case extraHeaders([String: String]) - Any extra HTTP headers that should be sent during the initial connection
 case forceNew(Bool) - позволяет переподключаться с новыми параметрами
 case forcePolling(Bool) - только HTTP long-polling а что еще может быть?
 case forceWebsockets(Bool) - only transport that will be used will be WebSockets.
 case handleQueue(DispatchQueue) - описание потока в котором должна выполняться обработка очереди, должно быть последовательным иначе будет краш приложения
 case log(Bool) - turned off in production code
 
 case logger(SocketLogger) - логирование для пользователя
 case reconnects(Bool)
 case reconnectAttempts(Int) - кол-во попыток повторного подключения -1 - не сдаваться
 case reconnectWait(Int)
 case secure(Bool) - для безопасных траспортов (по умолчанию ставится для https://)
 case security(SSLSecurity) - позволяет установить действительные сертификаты хорошо для SSL соединения.
 case selfSigned(Bool) - If you're using a self-signed set. Only use for development.
 case sessionDelegate(URLSessionDelegate) - Sets an NSURLSessionDelegate for the underlying engine. Useful if you need to handle self-signed certs.
 ======================================================
 SocketIOClient
 контролирует подключение к серверу
 nsp
 sid - из движка менеджера (session id)
 status - подключения
 
 open func connect()
 open func connect(timeoutAfter: Double, withHandler handler: (() -> ())?)
 open func disconnect()
 open func emit(_ event: String, with items: [Any])
 open func emitWithAck(_ event: String, with items: [Any]) -> OnAckCallback
 /// socket.emitWithAck("myEvent", with: [1]).timingOut(after: 1) {data in
 ///     ...
 /// }
 open func emitAck(_ ack: Int, with items: [Any])
 */

