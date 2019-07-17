Class {
	#name : #BlTktResponsiveCommand,
	#superclass : #BlTktValuableCommand,
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #defaults }
BlTktResponsiveCommand >> defaultValuable [
	^ [ :aTBlTktRequests | "do nothing" ]
]

{ #category : #evaluating }
BlTktResponsiveCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self valuable value: self requestContext.
]
