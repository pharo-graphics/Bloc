"
I am a default implementation of communication interface between data source manager and infinite element.
It is enough to use me in most cases.
"
Class {
	#name : #BlInfiniteDefaultDataSourceController,
	#superclass : #BlInfiniteAbstractDataSourceController,
	#instVars : [
		'dataSourceManager',
		'infiniteElement'
	],
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> applyPendingCommandsOnPosition: aPosition [
	^ self dataSourceManager applyPendingCommandsOnPosition: aPosition
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> computePositionOffset: aPosition [
	^ self dataSourceManager computePositionOffset: aPosition
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> consumeCommandsInOnePass [
	^ self dataSourceManager consumeCommandsInOnePass
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> consumePostponedCommands [
	self dataSourceManager consumePostponedCommands
]

{ #category : #private }
BlInfiniteDefaultDataSourceController >> createAddCommand: startPosition itemCount: itemCount [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeAdd instance
		positionStart: startPosition
		itemCount: itemCount
		payload: nil
]

{ #category : #private }
BlInfiniteDefaultDataSourceController >> createMoveCommand: fromPosition itemCount: toPosition [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeMove instance
		positionStart: fromPosition
		itemCount: toPosition
		payload: nil
]

{ #category : #private }
BlInfiniteDefaultDataSourceController >> createRemoveCommand: startPosition itemCount: itemCount [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeRemove instance
		positionStart: startPosition
		itemCount: itemCount
		payload: nil
]

{ #category : #private }
BlInfiniteDefaultDataSourceController >> createUpdateCommand: startPosition itemCount: itemCount payload: anObject [

	^ self dataSourceManager
		createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
		positionStart: startPosition
		itemCount: itemCount
		payload: anObject
]

{ #category : #accessing }
BlInfiniteDefaultDataSourceController >> dataSourceManager [
	"Return data source manager used in communication with infinite element.
	dataSourceManager can not be nil"
	<return: #BlInfiniteDataSourceManager>
	self assert: dataSourceManager isNotNil.
	
	^ dataSourceManager
]

{ #category : #accessing }
BlInfiniteDefaultDataSourceController >> dataSourceManager: aDataSourceManager [
	dataSourceManager := aDataSourceManager.
	dataSourceManager controller: self
]

{ #category : #private }
BlInfiniteDefaultDataSourceController >> dispatchCommand: aCommand [
	"Dispatche data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: self element layout
]

{ #category : #accessing }
BlInfiniteDefaultDataSourceController >> element [
	"Return infinite element used in communication with data source manager.
	element can not be nil"
	<return: #BlInfiniteElement>
	self assert: infiniteElement isNotNil.
	
	^ infiniteElement
]

{ #category : #accessing }
BlInfiniteDefaultDataSourceController >> element: anInfiniteElement [
	infiniteElement := anInfiniteElement
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> elementHolderAt: aPosition [
	<return: #BlElement or: nil>

	^ (infiniteElement findElementHolderForPosition: aPosition checkNew: true)
		ifNotNil: [ :anElementHolder |
			"ensure it is not hidden because for datasource manager,
			the only thing matter is that layout thinks element is a child"
			(infiniteElement childrenManager isHidden: anElementHolder itemElement)
				ifTrue: [ nil ]
				ifFalse: [ anElementHolder ] ]
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> hasCommands [
	^ self dataSourceManager hasCommands
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> hasPendingCommands [
	^ self dataSourceManager hasPendingCommands
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> markElementHoldersUpdated: aPositionStart itemCount: anItemCount payload: aPayloadObject [

	infiniteElement
		elementRangeUpdate: aPositionStart
		itemCount: anItemCount
		payload: aPayloadObject.
		
	infiniteElement markItemsChanged
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> offsetPositions: aStartPosition forAdd: anItemCount [
	
	infiniteElement
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.
		
	infiniteElement markItemsAddedOrRemoved
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> offsetPositions: aStartPosition forRemovingInvisible: anItemCount [
	| newDeletedCount |

	infiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	infiniteElement markItemsAddedOrRemoved.

	newDeletedCount := infiniteElement state deletedInvisibleItemCountSincePreviousLayout + anItemCount.
	infiniteElement state deletedInvisibleItemCountSincePreviousLayout: newDeletedCount
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> offsetPositions: aStartPosition forRemovingLaidOutOrNewElement: anItemCount [

	infiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	infiniteElement markItemsAddedOrRemoved
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> offsetPositionsForMove: aFromPosition to: aToPosition [

	infiniteElement
		offsetPositionRecordsForMove: aFromPosition
		to: aToPosition.

	infiniteElement markItemsAddedOrRemoved
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> onDispatchFirstPass: aCommand [
	self dispatchCommand: aCommand
]

{ #category : #'manager -> element' }
BlInfiniteDefaultDataSourceController >> onDispatchSecondPass: aCommand [
	self dispatchCommand: aCommand
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> onItemRangeChanged: aStartPosition itemCount: anItemCount payload: aPayloadObject [
	^ self dataSourceManager onItemRangeChanged: aStartPosition itemCount: anItemCount payload: aPayloadObject
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> onItemRangeInserted: startPosition itemCount: anItemCount [
	^ self dataSourceManager onItemRangeInserted: startPosition itemCount: anItemCount
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> preProcessCommands [
	self dataSourceManager preProcessCommands
]

{ #category : #'element -> manager' }
BlInfiniteDefaultDataSourceController >> resetCommands [
	self dataSourceManager resetCommands
]
