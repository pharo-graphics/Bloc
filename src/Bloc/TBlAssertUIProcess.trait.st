"
I check whether a code is executed in a Bloc UI process.
I should be used by ${class:BlElement}$.

"
Trait {
	#name : #TBlAssertUIProcess,
	#category : #'Bloc-Utilities - Debugging'
}

{ #category : #asserting }
TBlAssertUIProcess >> assertUIProcess [
	"Make sure that I am executing in a UI process"
	| aCurrentProcess aUIProcess |
	
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].
		
	self space isOpened
		ifFalse: [ ^ self ].

	aCurrentProcess := Processor activeProcess.	

	aUIProcess := nil.
	self space host uiProcessDo: [ :aProcess | aUIProcess := aProcess ].

	aUIProcess
		ifNil: [ ^ self ].
		
	(aUIProcess == aCurrentProcess)
		ifFalse: [ self error: ('I am running from a non-UI process ({1}) expected ({2})' format: { aCurrentProcess asString . aUIProcess asString }) ]
]
