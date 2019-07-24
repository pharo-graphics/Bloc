Class {
	#name : #BlTktUnresponsiveCommand,
	#superclass : #BlTktValuableCommand,
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #defaults }
BlTktUnresponsiveCommand >> defaultValuable [
	^ [ "do nothing" ]
]

{ #category : #evaluating }
BlTktUnresponsiveCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self valuable value
]
