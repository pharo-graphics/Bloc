Extension { #name : #BlockClosure }

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> asBlTktCommand [
	<return: #BlTktValuableCommand>
	self numArgs = 0 ifTrue: [ ^ BlTktUnresponsiveCommand new valuable: self; name: self printString ].
	self numArgs = 1 ifTrue: [ ^ BlTktResponsiveCommand new valuable: self; name: self printString ].
	self error: 'BlockClosure must have zero or one argument'
]

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> asBlTktTerminableCommand [
	^ BlTktTerminableCommand new command: self asBlTktCommand
]

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> asLoggingTask [ 
	"Answer the receiver as a task that will log its execution"

	^BlLoggingTask new 
		valuable: self;
		callingMethod: thisContext sender method asRingDefinition;
		yourself
]

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]
