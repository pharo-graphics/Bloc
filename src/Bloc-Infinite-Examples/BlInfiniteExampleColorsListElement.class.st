Class {
	#name : #BlInfiniteExampleColorsListElement,
	#superclass : #BlInfiniteElement,
	#category : 'Bloc-Infinite-Examples-Core - Colors'
}

{ #category : #initialization }
BlInfiniteExampleColorsListElement >> defaultDataSource [
	^ BlInfiniteExampleColorsDataSource new
]

{ #category : #initialization }
BlInfiniteExampleColorsListElement >> defaultLayout [
	^ BlInfiniteLinearLayout new
]
