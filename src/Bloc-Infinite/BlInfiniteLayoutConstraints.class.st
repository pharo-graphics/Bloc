Class {
	#name : #BlInfiniteLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'holder',
		'decorationInsets',
		'insertsDirty',
		'pendingInvalidate'
	],
	#category : #'Bloc-Infinite-Layout'
}

{ #category : #accessing }
BlInfiniteLayoutConstraints >> decorationInsets [
	^ decorationInsets
]

{ #category : #accessing }
BlInfiniteLayoutConstraints >> decorationInsets: aBlInsets [
	decorationInsets := aBlInsets
]

{ #category : #'initialize-release' }
BlInfiniteLayoutConstraints >> defaultHolder [

	^ BlInfiniteHolder new
]

{ #category : #'accessing - position' }
BlInfiniteLayoutConstraints >> elementDataSourcePosition [
	"Returns the up-to-date datasource position that the element I am attached to corresponds to"
	<return: #Number>

	^ holder dataSourcePosition
]

{ #category : #'accessing - position' }
BlInfiniteLayoutConstraints >> elementLayoutPosition [
	"Returns the datasource position that the element I am attached to corresponds to as of latest layout calculation"
	<return: #Number>

	^ holder position
]

{ #category : #accessing }
BlInfiniteLayoutConstraints >> holder [
	"Return an element holder of the element I am attached to.
	holder can not be nil in an infinite. 
	It can be nil if used in another context than an infinite"
	<return: #BlInfiniteHolder>

	^ holder
]

{ #category : #accessing }
BlInfiniteLayoutConstraints >> holder: anElementHolder [
	"Change an element holder of the element I am attached to.
	anElement holder must not be nil"
	
	self
		assert: [ anElementHolder isNotNil ]
		description: [ 'An element holder must not be nil' ].

	holder := anElementHolder
]

{ #category : #'initialize-release' }
BlInfiniteLayoutConstraints >> initialize [
	super initialize.
	
	holder := self defaultHolder.
	insertsDirty := true.
	pendingInvalidate := false
]

{ #category : #'private - accessing' }
BlInfiniteLayoutConstraints >> insetsDirty [
	^ insertsDirty
]

{ #category : #'private - accessing' }
BlInfiniteLayoutConstraints >> insetsDirty: aBoolean [
	insertsDirty := aBoolean
]

{ #category : #testing }
BlInfiniteLayoutConstraints >> isElementInvalid [
	"Returns true if the element I am attached to is now representing potentially invalid data.
	An InfiniteLayout should scrap/recycle it."
	
	^ holder isInvalid
]

{ #category : #testing }
BlInfiniteLayoutConstraints >> isItemRemoved [
	"Returns true if the datasource item corresponding to the element I am attached to has been removed from the data set.
	An InfiniteLayout may choose to treat it differently in order to animate its outgoing or disappearing state"
	<return: #Boolean>

	^ holder isRemoved
]

{ #category : #testing }
BlInfiniteLayoutConstraints >> isItemUpdated [
	"Returns true if the datasource item corresponding to the element I am attached to has been changed in the data set.
	An InfiniteElement may choose to treat it differently in order to animate its changing state."

	<return: #Boolean>
	^ holder isItemUpdated
]

{ #category : #'private - accessing' }
BlInfiniteLayoutConstraints >> pendingInvalidate [
	^ pendingInvalidate
]

{ #category : #'private - accessing' }
BlInfiniteLayoutConstraints >> pendingInvalidate: aBoolean [
	pendingInvalidate := aBoolean
]
