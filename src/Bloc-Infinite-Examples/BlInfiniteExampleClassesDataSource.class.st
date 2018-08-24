Class {
	#name : #BlInfiniteExampleClassesDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'classes'
	],
	#category : 'Bloc-Infinite-Examples-Core - Classes'
}

{ #category : #initialization }
BlInfiniteExampleClassesDataSource >> initialize [
	super initialize.
	
	classes := Smalltalk allClasses asArray
]

{ #category : #accessing }
BlInfiniteExampleClassesDataSource >> itemCount [
	^ classes size
]

{ #category : #'instance creation' }
BlInfiniteExampleClassesDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"
	anElementHolder class: (classes at: aPosition)
]

{ #category : #'instance creation' }
BlInfiniteExampleClassesDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlInfiniteExampleClassElementHolder new
]
