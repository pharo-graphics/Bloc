Class {
	#name : #BlTktWrapperCommand,
	#superclass : #BlTktDecoratedCommand,
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #evaluating }
BlTktWrapperCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self command execute
]

{ #category : #accessing }
BlTktWrapperCommand >> name [
	<return: #String>
	^ self command name
]
