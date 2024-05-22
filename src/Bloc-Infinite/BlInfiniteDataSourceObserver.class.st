"
I am an observer for watching changes to an DataSource
"
Class {
	#name : #BlInfiniteDataSourceObserver,
	#superclass : #BlBasicEventHandler,
	#category : #'Bloc-Infinite-DataSource'
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
BlInfiniteDataSourceObserver >> infiniteDataSourceChanged: anEvent [
	"@see BlInfiniteDataSourceChanged"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> infiniteDataSourceItemRangeChanged: anEvent [
	"@see BlInfiniteDataSourceItemRangeChanged"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> infiniteDataSourceItemRangeEvent: anEvent [
	"@see BlInfiniteDataSourceItemRangeEvent"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> infiniteDataSourceItemRangeInserted: anEvent [
	"@see BlInfiniteDataSourceItemRangeInserted"

	self subclassResponsibility
]

{ #category : #'event handling' }
BlInfiniteDataSourceObserver >> infiniteDataSourceItemRangeRemoved: anEvent [
	"@see BlInfiniteDataSourceItemRangeRemoved"

	self subclassResponsibility
]

{ #category : #events }
BlInfiniteDataSourceObserver >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
