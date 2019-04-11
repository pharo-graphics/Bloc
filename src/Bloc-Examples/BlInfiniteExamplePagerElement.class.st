Class {
	#name : #BlInfiniteExamplePagerElement,
	#superclass : #BlInfiniteElement,
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #initialization }
BlInfiniteExamplePagerElement >> defaultDataSource [
	^ BlInfiniteExamplePagerPanesDataSource new
]

{ #category : #initialization }
BlInfiniteExamplePagerElement >> defaultLayout [
	^ BlInfiniteLinearLayout new beHorizontal
]
