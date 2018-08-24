"
I represent a data source update command.

There are 4 times of commands: add, move, remove and update.

Add command describes insertion of one or multiple items in data source.
Move command describes a position change of existing item in data source.
Remove command describes deletion of one or multiple items from data source.
Update command describes content or value change of one or multiple items in data source.
"
Class {
	#name : #BlInfiniteDataSourceCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'positionStart',
		'payload',
		'itemCount',
		'type'
	],
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #commands }
BlInfiniteDataSourceCommand >> applyOn: aContext [
	self type apply: self on: aContext
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> applyOnPosition: aPosition [
	^ self type apply: self onPosition: aPosition
]

{ #category : #factory }
BlInfiniteDataSourceCommand >> beAdd [
	self type: BlInfiniteDataSourceCommandTypeAdd instance
]

{ #category : #factory }
BlInfiniteDataSourceCommand >> beMove [
	self type: BlInfiniteDataSourceCommandTypeMove instance
]

{ #category : #factory }
BlInfiniteDataSourceCommand >> beRemove [
	self type: BlInfiniteDataSourceCommandTypeRemove instance
]

{ #category : #factory }
BlInfiniteDataSourceCommand >> beUpdate [
	self type: BlInfiniteDataSourceCommandTypeUpdate instance
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> continuous: aPosition start: start [
	^ self type continuous: aPosition start: start
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> dispatchToLayout: aLayout [
	self type dispatch: self toLayout: aLayout
]

{ #category : #initialization }
BlInfiniteDataSourceCommand >> initialize [
	super initialize.
	
	type := BlInfiniteDataSourceCommandTypeNull instance
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isAdd [
	^ self type isAdd
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isMove [
	^ self type isMove
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isRemove [
	^ self type isRemove
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isUpdate [
	^ self type isUpdate
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> itemCount [
	^ itemCount
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> offsetPositionsOn: aDataSourceController [
	self type offsetPositions: self on: aDataSourceController
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> payload [
	^ payload
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> payload: anObject [
	payload := anObject
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> positionMultiplier [
	^ self type positionMultiplier
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> positionStart [
	^ positionStart
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> positionStart: anObject [
	positionStart := anObject
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	self type swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> type [
	<return: #BlInfiniteDataSourceCommandType>

	^ type
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> type: aType [
	self
		assert: [ aType isNotNil ]
		description: [ 'Type can not be nil' ].

	type := aType
]

{ #category : #enum }
BlInfiniteDataSourceCommand >> typeInvisible [
	^ 0
]

{ #category : #enum }
BlInfiniteDataSourceCommand >> typeNewOrLaidOut [
	^ 1
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updateElementHoldersOn: aContext [
	^ self type updateElementHoldersOn: aContext command: self
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updateElementHoldersOn: aContext offset: offsetStart [
	self type updateElementHoldersOn: aContext offset: offsetStart command: self
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updatePosition: aPosition with: aCommand [
	^ self type updatePosition: aPosition with: aCommand from: self
]
