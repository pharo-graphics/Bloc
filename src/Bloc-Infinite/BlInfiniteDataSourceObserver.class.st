"
I am an observer for watching changes to an DataSource
"
Class {
	#name : #BlInfiniteDataSourceObserver,
	#superclass : #BlBasicEventHandler,
	#category : 'Bloc-Infinite-DataSource'
}

{ #category : #events }
BlInfiniteDataSourceObserver >> eventClass [
	^ BlInfiniteDataSourceEvent
]

{ #category : #events }
BlInfiniteDataSourceObserver >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> onChanged: anEvent [
	"@see BlInfiniteDataSourceChanged"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> onItemsChanged: anEvent [
	"@see BlInfiniteDataSourceItemRangeChanged"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> onItemsEvent: anEvent [
	"@see BlInfiniteDataSourceItemRangeEvent"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> onItemsInserted: anEvent [
	"@see BlInfiniteDataSourceItemRangeInserted"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> onItemsMoved: anEvent [
	"@see BlInfiniteDataSourceItemRangeMoved"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> onItemsRemoved: anEvent [
	"@see BlInfiniteDataSourceItemRangeRemoved"

	self subclassResponsibility
]

{ #category : #events }
BlInfiniteDataSourceObserver >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
