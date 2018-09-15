Class {
	#name : #BlDecoratedCommand,
	#superclass : #BlCommand,
	#instVars : [
		'command'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #testing }
BlDecoratedCommand class >> isAbstract [
	^ self name = #GtDecoratedCommand 
]

{ #category : #accessing }
BlDecoratedCommand >> catchingErrors [
	^ command catchingErrors
]

{ #category : #accessing }
BlDecoratedCommand >> command [
	<return: #BlCommand>
	^ command
]

{ #category : #accessing }
BlDecoratedCommand >> command: aGtCommand [
	self 
		assert: [ aGtCommand notNil ] 
		description: [ 'Command to execute must be non-nil' ].
	command := aGtCommand
]

{ #category : #initialization }
BlDecoratedCommand >> initialize [
	super initialize.
	command := BlNullCommand uniqueInstance.
]
