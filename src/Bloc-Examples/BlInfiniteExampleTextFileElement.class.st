"
[[[
BlInfiniteExampleTextFileElement new
	background: (Color gray alpha: 0.2);
	constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ];
	textFile: 'PharoDebug.log' asFileReference
] ] ]
"
Class {
	#name : #BlInfiniteExampleTextFileElement,
	#superclass : #BlInfiniteElement,
	#category : #'Bloc-Examples-Infinite Files'
}

{ #category : #initialization }
BlInfiniteExampleTextFileElement >> defaultDataSource [
	^ BlInfiniteExampleTextFileDataSource new
]

{ #category : #initialization }
BlInfiniteExampleTextFileElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #accessing }
BlInfiniteExampleTextFileElement >> textFile: aFileReference [
	self dataSource textFile: aFileReference
]
