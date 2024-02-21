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
		'itemCount',
		'type'
	],
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #commands }
BlInfiniteDataSourceCommand >> applyIn: anInfiniteElement [


	"In case of scrolling, only for item change (no add-remove-move). Check
	if any of the visible items is affected and if not, just ignore the change."
	type apply: self in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> applyOnPosition: aPosition [
	"When the position of an ElementHolder is required.
	Determine how provided position will change. Return the position after command is processed"

	^ type apply: self onPosition: aPosition
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
	^ type continuous: aPosition start: start
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> dispatchToLayout: aLayout [
	type dispatch: self toLayout: aLayout
]

{ #category : #initialization }
BlInfiniteDataSourceCommand >> initialize [
	super initialize.
	
	type := BlInfiniteDataSourceCommandTypeNull instance
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isAdd [
	^ type isAdd
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isMove [
	^ type isMove
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isRemove [
	^ type isRemove
]

{ #category : #testing }
BlInfiniteDataSourceCommand >> isUpdate [
	^ type isUpdate
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
BlInfiniteDataSourceCommand >> offsetPositionsIn: anInfiniteElement [
	type offsetPositions: self in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> positionMultiplier [
	^ type positionMultiplier
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> positionStart [
	^ positionStart
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> positionStart: anObject [
	positionStart := anObject
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> type [
	<return: #BlInfiniteDataSourceCommandType>

	^ type
]

{ #category : #accessing }
BlInfiniteDataSourceCommand >> type: aType [

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
BlInfiniteDataSourceCommand >> updateElementHoldersIn: anInfiniteElement [
	^ type updateElementHoldersIn: anInfiniteElement command: self
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updateElementHoldersIn: anInfiniteElement offset: offsetStart [
	type updateElementHoldersIn: anInfiniteElement offset: offsetStart command: self
]

{ #category : #commands }
BlInfiniteDataSourceCommand >> updatePosition: aPosition with: aCommand [
	^ type updatePosition: aPosition with: aCommand from: self
]
