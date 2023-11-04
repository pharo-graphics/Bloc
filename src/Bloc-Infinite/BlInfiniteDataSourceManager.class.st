"
I manage data source update commands.

I control their order and optimize commands queue.
For example if there are two sequential commands: add and remove at the same position, I annihilate them and do nothing.

My onItemRange* methods are triggered directly or indirectly by data source when it is changed.

Public API and Key Messages

- onItemRangeChanged: itemCount: payload: - is sent by data source when content or value of items was changed
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	commandsReorderer:		<Object>
	controller:		<Object>
	pendingCommands:		<Object>
	postponedCommands:		<Object>


    Implementation Points

"
Class {
	#name : #BlInfiniteDataSourceManager,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'pendingCommands',
		'postponedCommands',
		'existingCommandTypes'
	],
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> applyPendingCommandsOnPosition: aPosition [
	"
	When the position of a an ElementHolder is required.
	Virually perform every pending command to determine how provided
	position will change.	Return new position if all commands would be actually performed"

	| position |

	position := aPosition.
	
	pendingCommands do: [ :command |
		position := command applyOnPosition: position ].
	
	^ position
]

{ #category : #helper }
BlInfiniteDataSourceManager >> canFindInPreLayout: aPosition [

	postponedCommands withIndexDo: [ :command :index | 
		command isMove
			ifTrue: [ 
				(self computePositionOffset: command itemCount firstPostponedItem: index + 1) = aPosition
					ifTrue: [ ^ true ] ]
			ifFalse: [ command isAdd
				ifTrue: [ 
					| end |
					end := command positionStart + command itemCount.
					command positionStart to: end - 1 do: [ :pos |
						(self computePositionOffset: pos firstPostponedItem: index + 1) = aPosition
							ifTrue: [ ^ true ] ] ] ] ].
	^ false
]

{ #category : #helper }
BlInfiniteDataSourceManager >> computePositionOffset: aPosition [

	^ self computePositionOffset: aPosition firstPostponedItem: 1
]

{ #category : #helper }
BlInfiniteDataSourceManager >> computePositionOffset: aPosition firstPostponedItem: firstPostponedItem [
	" Sent when scrolling the infinite "

	| position |
	position := aPosition.

	firstPostponedItem to: postponedCommands size - 1 do: [ :index |
		| command |
		command := postponedCommands at: index.
		command positionStart <= position ifTrue: [
			command isRemove
				ifTrue: [
					position < (command positionStart + command itemCount) ifTrue: [ ^ 0 ].
					position := position - command itemCount ]
				ifFalse: [ command isAdd ifTrue: [ position := position + command itemCount ] ] ] ].
	^ position
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> consumeCommandsInOnePassIn: anInfiniteElement [
	"Skip pre-processing and perform all pending commands in one pass."

	"we still consume postponed updates (if there is) in case there was a pre-process call
	w/o a matching consumePostponedUpdates."
		
	self consumePostponedCommandsIn: anInfiniteElement.

	pendingCommands do: [ :command |
		self dispatchCommand: command to: anInfiniteElement.
		command offsetPositionsIn: anInfiniteElement.
		self onCommandProcessed: command in: anInfiniteElement].

	self recycleCommandsAndClearList: pendingCommands.
	existingCommandTypes clear
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> consumePostponedCommandsIn: anInfiniteElement [

	postponedCommands do: [ :command |
		self dispatchCommand: command to: anInfiniteElement].

	self recycleCommandsAndClearList: postponedCommands.
	existingCommandTypes clear
]

{ #category : #'commands recycling' }
BlInfiniteDataSourceManager >> createCommand: type positionStart: positionStart itemCount: itemCount [
	"Return a data source command with specified parameters"
	<return: #BlInfiniteDataSourceCommand>
	
	^ BlInfiniteDataSourceCommand new
			type: type;
			positionStart: positionStart;
			itemCount: itemCount
]

{ #category : #private }
BlInfiniteDataSourceManager >> dispatchAndUpdateElementHolders: aCommand on: anInfiniteElement [
	| tmpStart tmpCnt offsetPositionForPartial positionMultiplier |
	tmpStart := self updatePosition: aCommand positionStart withPostponed: aCommand.
	tmpCnt := 1.
	offsetPositionForPartial := aCommand positionStart.
	positionMultiplier := aCommand positionMultiplier.
	
	1 to: aCommand itemCount - 1 do: [ :p |
		| pos updatedPos |
		pos := aCommand positionStart + (positionMultiplier * p).
		updatedPos := self updatePosition: pos withPostponed: aCommand.
		(aCommand continuous: updatedPos start: tmpStart)
			ifTrue: [ tmpCnt := tmpCnt + 1 ]
			ifFalse: [ 
				| tmpCommand |
				tmpCommand := aCommand class new
					positionStart: tmpStart;
					itemCount: tmpCnt.
				
				self dispatchFirstPassAndUpdateElementHolders: tmpCommand offset: offsetPositionForPartial in: anInfiniteElement.
				self recycleCommand: tmpCommand.
				
				aCommand isUpdate ifTrue: [ 
					offsetPositionForPartial := offsetPositionForPartial + tmpCnt ].
				tmpStart := updatedPos.
				tmpCnt := 1 ] ].

	self recycleCommand: aCommand.
	
	tmpCnt > 0 ifTrue: [ 
		|tmpCommand|
		tmpCommand := aCommand class new
			positionStart: tmpStart;
			itemCount: tmpCnt.
		self dispatchFirstPassAndUpdateElementHolders: tmpCommand offset: offsetPositionForPartial in: anInfiniteElement.
		self recycleCommand: tmpCommand ].
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> dispatchCommand: aCommand to: anInfiniteElement [
	"Dispatche data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: anInfiniteElement layout
]

{ #category : #helper }
BlInfiniteDataSourceManager >> dispatchFirstPassAndUpdateElementHolders: aCommand offset: offsetStart in: anInfiniteElement [

	self dispatchCommand: aCommand to: anInfiniteElement.
	aCommand updateElementHoldersIn: anInfiniteElement offset: offsetStart
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasAddCommand [
	"Return true if there are any add commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasAdd
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasCommands [
	"Return true if there are both pending and postponed commands,
	otherwise false"
	<return: #Boolean>

	^ self hasPendingCommands and: [ self hasPostponedCommands ]
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasMoveCommand [
	"Return true if there are any move commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasMove
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasOnlyUpdateCommand [
	"Return true if there are only update commands in the queue, false otherwise"
	<return: #Boolean>

	^ self hasUpdateCommand and: [
		(self hasAddCommand or: [
			self hasRemoveCommand or: [ 
				self hasMoveCommand ] ]) not ]
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasPendingCommands [
	"Return true if there are pending commands,
	false otherwise"
	<return: #Boolean>

	^ pendingCommands isNotEmpty
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasPostponedCommands [
	"Return true if there are postponed commands,
	false otherwise"
	<return: #Boolean>

	^ postponedCommands isNotEmpty
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasRemoveCommand [
	"Return true if there are any remove commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasRemove
]

{ #category : #'testing - commands' }
BlInfiniteDataSourceManager >> hasUpdateCommand [
	"Return true if there are any update commands in the queue, false otherwise"
	<return: #Boolean>

	^ existingCommandTypes hasUpdate
]

{ #category : #initialization }
BlInfiniteDataSourceManager >> initialize [
	super initialize.
	
	postponedCommands := OrderedCollection new.
	pendingCommands := OrderedCollection new.
	"commandsReorderer := self defaultCommandsReorderer dataSourceManager: self."
	existingCommandTypes := BlInfiniteDataSourceCommandTypeFlags new
]

{ #category : #'manager -> element' }
BlInfiniteDataSourceManager >> markElementHoldersUpdated: aPositionStart itemCount: anItemCount in: anInfiniteElement [

	anInfiniteElement
		elementRangeUpdate: aPositionStart
		itemCount: anItemCount.
		
	anInfiniteElement markItemsChanged
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> offsetPositions: aStartPosition forAdd: anItemCount in: anInfiniteElement [
	
	anInfiniteElement
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.
		
	anInfiniteElement markItemsAddedOrRemoved
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> offsetPositions: aStartPosition forRemovingInvisible: anItemCount in: anInfiniteElement [
	| newDeletedCount |

	anInfiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	anInfiniteElement markItemsAddedOrRemoved.

	newDeletedCount := anInfiniteElement state deletedInvisibleItemCountSincePreviousLayout + anItemCount.
	anInfiniteElement state deletedInvisibleItemCountSincePreviousLayout: newDeletedCount
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> offsetPositions: aStartPosition forRemovingLaidOutOrNewElement: anItemCount in: anInfiniteElement [

	anInfiniteElement
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: true.
	
	anInfiniteElement markItemsAddedOrRemoved
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> offsetPositionsForMove: aFromPosition to: aToPosition in: anInfiniteElement [

	anInfiniteElement
		offsetPositionRecordsForMove: aFromPosition
		to: aToPosition.

	anInfiniteElement markItemsAddedOrRemoved
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> onCommandProcessed: aCommand in: anInfiniteElement [

]

{ #category : #'data source updates' }
BlInfiniteDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [
	"Enqueues a new update pending command.
	I am a part of public API and should be triggered by data source (directly or indirectly)
	when items are changed/updated (item's value, content, or value was replaced in-place).
	Return true if pending commands need to be processed, otherwise false."
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register update command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
		positionStart: aPositionStart
		itemCount: anItemCount).
	existingCommandTypes addUpdate.

	^ pendingCommands size = 1
]

{ #category : #'data source updates' }
BlInfiniteDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register add command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeAdd instance
		positionStart: aPositionStart
		itemCount: anItemCount).
	existingCommandTypes addAdd.

	^ pendingCommands size = 1
]

{ #category : #'data source updates' }
BlInfiniteDataSourceManager >> onItemRangeMoved: aPositionStart to: aPositionEnd itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If start and end position are the same, nothing needs to be done"
	aPositionStart = aPositionEnd
		ifTrue: [ ^ false ].
		
	anItemCount > 1
		ifTrue: [ self error: 'Moving multiple items is not supported yet' ].

	"Register move command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeMove instance
		positionStart: aPositionStart
		itemCount: aPositionEnd).
	existingCommandTypes addMove.

	^ pendingCommands size = 1
]

{ #category : #'data source updates' }
BlInfiniteDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register remove command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeRemove instance
		positionStart: aPositionStart
		itemCount: anItemCount).
	existingCommandTypes addRemove.

	^ pendingCommands size = 1
]

{ #category : #private }
BlInfiniteDataSourceManager >> postponeAndUpdateElementHolders: aCommand on: anInfiniteElement [

	postponedCommands add: aCommand.
	aCommand updateElementHoldersIn: anInfiniteElement.
]

{ #category : #'commands processing' }
BlInfiniteDataSourceManager >> preProcessCommandsIn: anInfiniteElement [

	"In case of scrolling, only for item change (no add-remove-move). Check
	if any of the visible items is affected and if not, just ignore the change."
	pendingCommands do: [ :command |
		command applyIn: anInfiniteElement.
		self onCommandProcessed: command in: anInfiniteElement].
	pendingCommands removeAll
]

{ #category : #'commands recycling' }
BlInfiniteDataSourceManager >> recycleCommand: aCommand [
	"Recycle aCommand if recycling enabled"

]

{ #category : #'commands recycling' }
BlInfiniteDataSourceManager >> recycleCommandsAndClearList: aCollectionOfCommands [
	"Recycle and remove all commands from aCollectionOfCommands.
	aCollectionOfCommands must not be nil"
	self assert: aCollectionOfCommands isNotNil.
	
	aCollectionOfCommands do: [ :command |
		self recycleCommand: command ].

	aCollectionOfCommands removeAll
]

{ #category : #invalidate }
BlInfiniteDataSourceManager >> resetCommands [
	
	self recycleCommandsAndClearList: pendingCommands.
	self recycleCommandsAndClearList: postponedCommands.
	existingCommandTypes clear
]

{ #category : #private }
BlInfiniteDataSourceManager >> updatePosition: aPosition withPostponed: aCommand [
	|pos|
	pos := aPosition.
	
	postponedCommands do: [ :postponed |
		pos := postponed updatePosition: pos with: aCommand ].
	
	postponedCommands copy reverseWithIndexDo: [ :postponed :i | 
		postponed isMove
			ifTrue: [ 
				(postponed itemCount = postponed positionStart
					or: [ postponed itemCount < 0 ])
						ifTrue: [ 
							postponedCommands removeAt: i.
							self recycleCommand: postponed ] ]
			ifFalse: [ 
				postponed itemCount <= 0
					ifTrue: [ 
						postponedCommands removeAt: i.
						self recycleCommand: postponed ] ] ].
	^ pos
]
