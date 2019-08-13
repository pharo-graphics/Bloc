Class {
	#name : #BlTktSingleCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'identifier'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #converting }
BlTktSingleCommand >> asBlTktSingleCommand [

	^self
]

{ #category : #accessing }
BlTktSingleCommand >> entryIdentifier [ 

	^identifier
]

{ #category : #evaluating }
BlTktSingleCommand >> execute [ 

	^self command execute
]

{ #category : #accessing }
BlTktSingleCommand >> identifier [
	^ identifier
]

{ #category : #accessing }
BlTktSingleCommand >> identifier: anObject [
	identifier := anObject
]

{ #category : #testing }
BlTktSingleCommand >> includesSingleCommand [

	^true
]

{ #category : #accessing }
BlTktSingleCommand >> name [ 

	^self command name
]
