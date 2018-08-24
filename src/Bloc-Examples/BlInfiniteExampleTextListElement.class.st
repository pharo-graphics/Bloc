Class {
	#name : #BlInfiniteExampleTextListElement,
	#superclass : #BlInfiniteElement,
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #initialization }
BlInfiniteExampleTextListElement >> defaultDataSource [
	^ BlInfiniteExampleTextDataSource new
]

{ #category : #initialization }
BlInfiniteExampleTextListElement >> defaultLayout [
	^ BlInfiniteLinearLayout new
]
