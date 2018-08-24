Class {
	#name : #BlInfiniteExampleTextListElement,
	#superclass : #BlInfiniteElement,
	#category : 'Bloc-Infinite-Examples-Core - Text'
}

{ #category : #initialization }
BlInfiniteExampleTextListElement >> defaultDataSource [
	^ BlInfiniteExampleTextDataSource new
]

{ #category : #initialization }
BlInfiniteExampleTextListElement >> defaultLayout [
	^ BlInfiniteLinearLayout new
]
