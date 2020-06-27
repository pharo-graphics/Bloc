"
I allow a command execution for a given allowed duration.
I terminate myself if I am not finished withing the allowed time.

"
Class {
	#name : #BlTktTimeLimitedCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'allowedDuration'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #accessing }
BlTktTimeLimitedCommand >> allowedDuration [
	^ allowedDuration
]

{ #category : #accessing }
BlTktTimeLimitedCommand >> allowedDuration: anObject [
	allowedDuration := anObject
]

{ #category : #accessing }
BlTktTimeLimitedCommand >> command: aCommand [
	self
		assert: [ aCommand isNotNil ]
		description: [ 'Command must be non-nil' ].
	super command: aCommand asBlTktTerminableCommand.
]

{ #category : #defaults }
BlTktTimeLimitedCommand >> defaultAllowedDuration [
	^ 30 seconds
]

{ #category : #evaluating }
BlTktTimeLimitedCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			BlTaskAtQueue default
				schedule: [ self terminate ]
				at: BlTime real now + self allowedDuration ].
	self command execute.
]

{ #category : #initialization }
BlTktTimeLimitedCommand >> initialize [
	super initialize.
	allowedDuration := self defaultAllowedDuration
]

{ #category : #accessing }
BlTktTimeLimitedCommand >> name [
	<return: #String>
	^ 'Time limited ', self command name
]
