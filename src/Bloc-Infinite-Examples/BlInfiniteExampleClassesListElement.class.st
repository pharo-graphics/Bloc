Class {
	#name : #BlInfiniteExampleClassesListElement,
	#superclass : #BlInfiniteElement,
	#category : 'Bloc-Infinite-Examples-Core - Classes'
}

{ #category : #initialization }
BlInfiniteExampleClassesListElement >> defaultDataSource [
	^ BlInfiniteExampleClassesDataSource new
]

{ #category : #initialization }
BlInfiniteExampleClassesListElement >> defaultLayout [
	^ BlInfiniteLinearLayout new
]
