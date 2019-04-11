"
I am a data source of the collection of all classes in the image
"
Class {
	#name : #BlInfiniteExampleClassesDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'classes'
	],
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #initialization }
BlInfiniteExampleClassesDataSource >> initialize [
	super initialize.

	classes := Smalltalk globals allClasses asArray
]

{ #category : #accessing }
BlInfiniteExampleClassesDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ classes size
]

{ #category : #accessing }
BlInfiniteExampleClassesDataSource >> itemTypeAt: aPosition [
	"All my items are homogene, it is enough to use a named item type"
	<return: #BlInfiniteItemType>

	^ BlInfiniteNamedItemType named: #class
]

{ #category : #'instance creation' }
BlInfiniteExampleClassesDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"
	anElementHolder class: (classes at: aPosition)
]

{ #category : #'instance creation' }
BlInfiniteExampleClassesDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlInfiniteExampleClassesElementHolder new
]
