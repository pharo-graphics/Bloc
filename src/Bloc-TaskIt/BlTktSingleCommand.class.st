"
BlTktSingleCommand gives commands an identifier which is used to ensure that only one instance of the command exists on the task queue at any moment.  Typically this is used to prevent the same operations being performed multime times, wasting resources.

The identifer is any object which will #= other queue entries that are considered duplicates.

Public API and Key Messages

- identifier:   Set the object to be used for command comparison

Commands are typically given an identifier with something like:

[[[
aBlTktCommand asBlTktSingleCommand identifier: self
]]]

where self is the object submitting the command for execution.

!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	identifier:		<Object>	the object used for entry identity comparison


!!!Implementation Points
"
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
