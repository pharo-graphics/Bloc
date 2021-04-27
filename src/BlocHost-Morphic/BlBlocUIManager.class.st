"
I provide a solution for handling the opening of the debugger that supports both the Bloc UI and the Morphic UI processes.

I assume there is only one UI Process either in Bloc or Morphic. If the error happened in either one of these processes, I restart the correct one. If both Bloc and Morphic have two distinct UI processes I will not work correctly.

Normally I should only be used when running Bloc natively. When running Bloc using inside the Morphic UI process the a ${class:MorphicUIManager}$ can be used instead.
However for now I can also be used to handle just the case of the Morhic UI process. Later I should be simplified to take into account only the Bloc UI process.
"
Class {
	#name : #BlBlocUIManager,
	#superclass : #MorphicUIManager,
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #'class initialization' }
BlBlocUIManager class >> handledId [
	^ self name
]

{ #category : #'class initialization' }
BlBlocUIManager class >> initialize [
	"has to be executed at the end of the user category"
	SessionManager default 
		register: self
		inCategory: SessionManager default userCategory  
		atPriority: SmallInteger maxVal + 1
]

{ #category : #testing }
BlBlocUIManager class >> isValidForCurrentSystemConfiguration [
	| isHeadlessVM isInteractiveMode |
	
	SystemVersion current major <= 8
		ifFalse: [ ^ false ].
	
	isHeadlessVM := Smalltalk os windowSystemName isNil or: [ Smalltalk os windowSystemName = 'null' ].
	
	"The --interactive parameter should be passed in order to select a graphical UI manager.
	This parameter is passe automatically when double clicking on the Headless VM."
	isInteractiveMode := CommandLineArguments new hasOption: 'interactive'.
		
	^ isHeadlessVM and: [ isInteractiveMode ]
]

{ #category : #'class initialization' }
BlBlocUIManager class >> shutdown: isImageQuitting [
	"Prepare the shutdown and the next startup"

	UIManager default: StartupUIManager new
	
]

{ #category : #'class initialization' }
BlBlocUIManager class >> startup: isImageStarting [
	"Install the right UIManager"
	
	UIManager default: (self isValidForCurrentSystemConfiguration
		ifTrue: [ self new ]
		ifFalse: [ UIManager forCurrentSystemConfiguration ])
]

{ #category : #actions }
BlBlocUIManager class >> useAsDefault [
	|uiManager|
	uiManager := self new.
	uiManager beDefault. 
]

{ #category : #services }
BlBlocUIManager >> abort: aStringOrText title: aString [
	^ BlBlocUIManagerNotification
		request: #abort:title:
		with:
			{aStringOrText.
			aString}
		default: [ true ]
]

{ #category : #services }
BlBlocUIManager >> alert: aStringOrText title: aString configure: aBlock [
	^ BlBlocUIManagerNotification
		request: #alert:title:configure:
		with:
			{aStringOrText.
			aString.
			aBlock}
		default: [ true ]
]

{ #category : #services }
BlBlocUIManager >> centeredAlert: aStringOrText title: aString configure: aBlock [
	^ BlBlocUIManagerNotification
		request: #centeredAlert:title:configure:
		with:
			{aStringOrText.
			aString.
			aBlock}
		default: [ true ]
]

{ #category : #services }
BlBlocUIManager >> chooseColor: aColor [
	^ self chooseColor: aColor title: 'Colour Selector' translated
]

{ #category : #services }
BlBlocUIManager >> chooseColor: aColor title: title [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseColor:title:
		with:
			{aColor.
			title}
]

{ #category : #'ui requests' }
BlBlocUIManager >> chooseDirectory: label from: dir [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseDirectory:from:
		with:
			{label.
			dir}
]

{ #category : #services }
BlBlocUIManager >> chooseDirectory: title path: path [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseDirectory:path:
		with:
			{title.
			path}
]

{ #category : #services }
BlBlocUIManager >> chooseDropList: aStringOrText title: aString list: aList [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseDropList:title:list:
		with:
			{aStringOrText.
			aString.
			aList}
]

{ #category : #services }
BlBlocUIManager >> chooseExistingFileReference: title extensions: exts path: path preview: preview [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseExistingFileReference:extensions:path:preview:
		with:
			{title.
			exts.
			path.
			preview}
]

{ #category : #services }
BlBlocUIManager >> chooseFont: aFont [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseFont:
		with: {aFont}
]

{ #category : #services }
BlBlocUIManager >> chooseForSaveFileReference: title extensions: exts path: path preview: preview [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseForSaveFileReference:extensions:path:preview:
		with:
			{title.
			exts.
			path.
			preview}
]

{ #category : #services }
BlBlocUIManager >> chooseFrom: labelList values: valueList lines: linesArray message: messageString title: aString [
	^ BlBlocUIManagerNotification
		request: #chooseFrom:values:lines:message:title:
		with:
			{labelList.
			valueList.
			linesArray.
			messageString.
			aString}
		default: [ 0 ]
]

{ #category : #'ui requests' }
BlBlocUIManager >> chooseFrom: labelList values: valueList lines: linesArray title: aString [
	^ BlBlocUIManagerNotification
		request: #chooseFrom:values:lines:title:
		with:
			{labelList.
			valueList.
			linesArray.
			aString}
		default: [ 0 ]
]

{ #category : #services }
BlBlocUIManager >> chooseFullFileName: title extensions: exts path: path preview: preview [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseFullFileName:extensions:path:preview:
		with:
			{title.
			exts.
			path.
			preview}
]

{ #category : #'ui requests' }
BlBlocUIManager >> chooseFullFileNameMatching: patterns label: label [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseFullFileNameMatching:label:
		with:
			{patterns.
			label}
]

{ #category : #services }
BlBlocUIManager >> chooseOrRequestFrom: labelList values: valueList lines: linesArray title: aString [
	^ BlBlocUIManagerNotification
		requestOrNil: #chooseOrRequestFrom:values:lines:title:
		with:
			{labelList.
			valueList.
			linesArray.
			aString}
]

{ #category : #'ui requests' }
BlBlocUIManager >> confirm: questionStringOrText label: labelStringOrText [
	^ BlBlocUIManagerNotification
		request: #confirm:label:
		with:
			{questionStringOrText.
			labelStringOrText}
		default: [ false ]
]

{ #category : #services }
BlBlocUIManager >> confirm: queryString label: title trueChoice: trueChoice falseChoice: falseChoice cancelChoice: cancelChoice default: defaultOption [
	^ BlBlocUIManagerNotification
		requestOrNil: #confirm:label:trueChoice:falseChoice:cancelChoice:default:
		with:
			{queryString.
			title.
			trueChoice.
			falseChoice.
			cancelChoice.
			defaultOption}
]

{ #category : #'ui requests' }
BlBlocUIManager >> confirm: aStringOrText orCancel: cancelBlock [
	^ BlBlocUIManagerNotification
		request: #confirm:orCancel:
		with:
			{aStringOrText.
			cancelBlock}
		default: cancelBlock
]

{ #category : #debug }
BlBlocUIManager >> debugProcess: process context: context label: title fullView: bool notification: notificationString [
	"Open the default debugger registered in the system as a result of the error."
	self 
		debugProcess: process 
		context: context 
		label: title 
		spawningDebuggingUsing: [ :debugSession | 
			Smalltalk tools debugger 
				openOn: debugSession withFullView: bool andNotification: notificationString ]
]

{ #category : #debug }
BlBlocUIManager >> debugProcess: process context: context label: title spawningDebuggingUsing: debuggerSpawnBlock [
	"I open the default debugger and add support for detecting if the 
	debugged process is the Morphic or Bloc UI process.
	I spawn a new Bloc UI process if the debugged process is the Bloc UI process 
	or a Morphic UI process if the debugged process is the Morphic UI process."
	| debugSession isForBlocUIProcess aBlocUniverseIfAny aDebuggerOpeningAction |
		
	debugSession := process newDebugSessionNamed: title startedAt: context.
	debugSession logStackToFileIfNeeded.
	
	isForBlocUIProcess := false.
	aBlocUniverseIfAny := nil.
	
	self
		universeForSession: debugSession
		ifPresent: [ :aUniverse |
			isForBlocUIProcess := true.
			aBlocUniverseIfAny := aUniverse.
			debugSession errorWasInUIProcess: true ]
		ifAbsent: [].
	
	debugSession isAboutUIProcess ifTrue: [ 
		DefaultExecutionEnvironment beActiveDuring: [
			isForBlocUIProcess "Handle the case of the Bloc UI process"
				ifTrue: [ self spawnNewBlocProcess: aBlocUniverseIfAny ]
				ifFalse: [ self spawnNewProcess ] ] ].
	
	aDebuggerOpeningAction := [ 
		[ 
			debuggerSpawnBlock value: debugSession.
		] on: Error do: [ :ex | 	
			debugSession signalDebuggerError: ex ] ].
	
	"Perform the opening of the debugger in defer action to suspend the UI."
	isForBlocUIProcess
		ifTrue: [ self defer: aDebuggerOpeningAction universe: aBlocUniverseIfAny ]
		ifFalse: [ debugSession isAboutUIProcess
			ifTrue: [ self defer: aDebuggerOpeningAction ]
			ifFalse: [ self
				universeDo: [ :aBlocUniverse | self defer: aDebuggerOpeningAction universe: aBlocUniverse  ]
				ifAbsent: [ self defer: aDebuggerOpeningAction ] ] ].

	process suspend
]

{ #category : #'ui process' }
BlBlocUIManager >> defer: aBlock universe: aBlocUniverseIfAny [
	"Defer aBloc in a given universe"
	
	aBlocUniverseIfAny defer: aBlock.
	aBlocUniverseIfAny hostClass isRunning
		ifFalse: [ aBlocUniverseIfAny startUniverse ]
]

{ #category : #services }
BlBlocUIManager >> deny: aStringOrText title: aString [
	^ BlBlocUIManagerNotification
		request: #deny:title:
		with:
			{aStringOrText.
			aString}
		default: [ false ]
]

{ #category : #'ui requests' }
BlBlocUIManager >> edit: aText label: labelString accept: aBlockOrNil [
	^ BlBlocUIManagerNotification
		request: #edit:label:accept:
		with:
			{aText.
			labelString.
			aBlockOrNil}
]

{ #category : #services }
BlBlocUIManager >> enterOrRequestFrom: labelList values: valueList lines: linesArray title: aString [
	^ BlBlocUIManagerNotification
		requestOrNil: #enterOrRequestFrom:values:lines:title:
		with:
			{labelList.
			valueList.
			linesArray.
			aString}
]

{ #category : #'ui requests' }
BlBlocUIManager >> inform: aStringOrText [
	^ BlBlocUIManagerNotification
		requestOrNil: #inform:
		with: {aStringOrText}
]

{ #category : #'ui process' }
BlBlocUIManager >> isBlocUIProcess: aProcess [ 
	"Check if the given process is a Bloc UI process.
	We consider it a Bloc UI process if is the UI process of a Universe."
	self 
		universeForProcess: aProcess 
		ifPresent: [ :processUniverse | ^ true ] 
		ifAbsent: [ ^ false ].
	^ false
]

{ #category : #services }
BlBlocUIManager >> longMessage: aStringOrText title: aString [
	^ BlBlocUIManagerNotification
		request: #longMessage:title:
		with:
			{aStringOrText.
			aString}
		default: [ false ]
]

{ #category : #'ui requests' }
BlBlocUIManager >> merge: merger informing: aString [
	^ BlBlocUIManagerNotification
		request: #merge:informing:
		with:
			{merger.
			aString}
]

{ #category : #services }
BlBlocUIManager >> message: aStringOrText title: aString [
	^ BlBlocUIManagerNotification
		requestOrNil: #message:title:
		with:
			{aStringOrText.
			aString}
]

{ #category : #'ui requests' }
BlBlocUIManager >> multiLineRequest: queryString initialAnswer: defaultAnswer answerHeight: answerHeight [
	^ BlBlocUIManagerNotification
		requestOrNil: #multiLineRequest:initialAnswer:answerHeight:
		with:
			{queryString.
			defaultAnswer.
			answerHeight}
]

{ #category : #events }
BlBlocUIManager >> onPrimitiveError: aString [ 
	| message |

	message := String
				streamContents: [:s | 
					| context |
					s nextPutAll: '*** System error handling failed ***'.
					s cr; nextPutAll: aString.
					context := thisContext sender sender.
					20
						timesRepeat: [context == nil
								ifFalse: [s cr; print: (context := context sender)]]].
	Smalltalk tools emergencyDebugger askForEmergencyEvaluatorOrExitWithText: message.
]

{ #category : #services }
BlBlocUIManager >> proceed: aStringOrText title: aString [
	^ BlBlocUIManagerNotification
		request: #proceed:title:
		with:
			{aStringOrText.
			aString}
		default: [ false ]
]

{ #category : #services }
BlBlocUIManager >> question: aStringOrText title: aString [
	^ BlBlocUIManagerNotification
		requestOrNil: #question:title:
		with:
			{aStringOrText.
			aString}
]

{ #category : #services }
BlBlocUIManager >> questionWithoutCancel: aStringOrText title: aString [
	^ BlBlocUIManagerNotification
		request: #questionWithoutCancel:title:
		with:
			{aStringOrText.
			aString}
		default: [ false ]
]

{ #category : #'ui requests' }
BlBlocUIManager >> request: aStringOrText initialAnswer: defaultAnswer title: aTitle [
	^ BlBlocUIManagerNotification
		requestOrNil: #request:initialAnswer:title:
		with:
			{aStringOrText.
			defaultAnswer.
			aTitle}
]

{ #category : #'ui requests' }
BlBlocUIManager >> request: aStringOrText initialAnswer: defaultAnswer title: aTitle entryCompletion: anEntryCompletion [
	^ BlBlocUIManagerNotification
		requestOrNil: #request:initialAnswer:title:entryCompletion:
		with:
			{aStringOrText.
			defaultAnswer.
			aTitle.
			anEntryCompletion}
]

{ #category : #'ui requests' }
BlBlocUIManager >> requestPassword: aStringOrText [
	^ BlBlocUIManagerNotification
		requestOrNil: #requestPassword:
		with: {aStringOrText}
]

{ #category : #'ui process' }
BlBlocUIManager >> resumeBlocUIProcess: aProcess [
	"Adopt aProcess as the UI process for Bloc -- probably because of proceeding from a debugger"

	"Resume the Bloc UI process normally by delegating the resume operation through the host. 
	This assumes that the debugger was opened and runs in the Bloc UI process.
	In case Bloc is embedded inside the Morphic World, the Bloc UI process is going to
	be the Morphic UI process. Delegating the process operations through the host
	ensures that the Morphic UI process will be resumed correctly."
	
	self
		universeForProcess: aProcess
		ifPresent: [ :aUniverse |
			"aUniverse stopPulsation." 
			aUniverse hostClass forceResumeOfUIProcess: aProcess ]
		ifAbsent: [  ].
]

{ #category : #'ui process' }
BlBlocUIManager >> resumeMorphicUIProcess: aProcess [ 
	"Adopt aProcess as the UI process for morphic -- probably because of proceeding from a debugger"

	"Resume the Morphic UI process normally without any special logic. 
	This assumes that the debugger was opened and runs in the Morphic UI process."
	UIProcess := aProcess.
	UIProcess resume
]

{ #category : #'ui process' }
BlBlocUIManager >> resumeUIProcess: aProcess [
	"Adopt aProcess as the project process -- probably because of proceeding from a debugger"

	"I explicitly check if the process corresponds to the Bloc UI process or not so I can determine which UI process to resume."
	(self isBlocUIProcess: aProcess)
		ifTrue:  [ 
			"Resume the Bloc UI process."
			self resumeBlocUIProcess: aProcess ]
		ifFalse: [ 
			"Resume the Moprhic UI process."
			self resumeMorphicUIProcess: aProcess ]
]

{ #category : #debug }
BlBlocUIManager >> spawnNewBlocProcess: aUniverse [
	aUniverse requestStopPulsation.
	aUniverse hostClass forceStartNewUIProcess
]

{ #category : #services }
BlBlocUIManager >> syntaxErrorNotificationDefaultAction: anException [
	^ BlBlocUIManagerNotification
		requestOrNil: #syntaxErrorNotificationDefaultAction:
		with: {anException}
]

{ #category : #services }
BlBlocUIManager >> textEntry: aStringOrText title: aString entryText: defaultEntryText [
	^ BlBlocUIManagerNotification
		requestOrNil: #textEntry:title:entryText:
		with:
			{aStringOrText.
			aString.
			defaultEntryText}
]

{ #category : #'ui process' }
BlBlocUIManager >> universeDo: aPresentBlock ifAbsent: anExceptionBlock [
	| theUniversesWithUIProcess |
	theUniversesWithUIProcess := (BlParallelUniverse all select: [ :eachUniverse |
			eachUniverse hasSpaces
				and: [ eachUniverse hasUIProcess
					and: [ eachUniverse hostClass new isRunning ] ] ])
		sorted: [ :a :b | a hostClass priority < b hostClass priority ].

	theUniversesWithUIProcess
		ifEmpty: anExceptionBlock
		ifNotEmpty: [ :theUniverses | aPresentBlock value: theUniverses first ]
]

{ #category : #'ui process' }
BlBlocUIManager >> universeForProcess: aProcess ifPresent: aPresentBlock ifAbsent: anExceptionBlock [
	^ BlParallelUniverse all
		detect: [ :eachUniverse |
			| isInterruptedProcess |
			isInterruptedProcess := false.
			eachUniverse hostClass
				uiProcessDo: [ :eachUIProcess | isInterruptedProcess := eachUIProcess name = aProcess name ].
			isInterruptedProcess ]
		ifFound: aPresentBlock
		ifNone: anExceptionBlock
]

{ #category : #'ui process' }
BlBlocUIManager >> universeForSession: debugSession ifPresent: aPresentBlock ifAbsent: anExceptionBlock [
	^ BlParallelUniverse all
		detect: [ :eachUniverse |
			| isInterruptedProcess |
			isInterruptedProcess := false.
			eachUniverse hostClass
				uiProcessDo: [ :eachUIProcess | isInterruptedProcess := eachUIProcess == debugSession interruptedProcess ].
			isInterruptedProcess ]
		ifFound: aPresentBlock
		ifNone: anExceptionBlock
]
