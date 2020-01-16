Class {
	#name : #BlTktExplicitlyTerminatedTaskException,
	#superclass : #Exception,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-TaskIt-TaskIt Tasks'
}

{ #category : #accessing }
BlTktExplicitlyTerminatedTaskException >> defaultAction [
	"No one has handled this error, but now give them a chance to decide how to debug it. If none handle this either then open debugger (see UnhandledError>>#defaultAction)"

	UnhandledError signalForException: self
]

{ #category : #testing }
BlTktExplicitlyTerminatedTaskException >> isResumable [ 
	"#withoutContext removes the signalContext, so this can't be resumed"

	^ false
]
