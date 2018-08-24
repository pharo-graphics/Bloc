Class {
	#name : #BlInfiniteExampleTextDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'text',
		'lines'
	],
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #initialization }
BlInfiniteExampleTextDataSource >> defaultText [
	| aText |
	aText := SpText fromString: (String loremIpsum: 1000000).
	^ aText
]

{ #category : #initialization }
BlInfiniteExampleTextDataSource >> initialize [
	super initialize.
	
	self text: self defaultText
]

{ #category : #accessing }
BlInfiniteExampleTextDataSource >> itemCount [
	^ lines size
]

{ #category : #private }
BlInfiniteExampleTextDataSource >> lineAt: aNumber [

	^ lines at: aNumber
]

{ #category : #'instance creation' }
BlInfiniteExampleTextDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"
	anElementHolder text: (SpText fromRope: (self lineAt: aPosition))
]

{ #category : #'instance creation' }
BlInfiniteExampleTextDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlInfiniteExampleTextElementHolder new
]

{ #category : #private }
BlInfiniteExampleTextDataSource >> splitLines: aSpText [
	| theLines aLineIterator |

	theLines := OrderedCollection new.
	aLineIterator := aSpText rope iterator.

	[ aLineIterator hasNext ] whileTrue: [ 
		theLines add: aLineIterator nextLine ].

	^ theLines
]

{ #category : #accessing }
BlInfiniteExampleTextDataSource >> text: aText [

	text := aText.
	lines := self splitLines: aText
]
