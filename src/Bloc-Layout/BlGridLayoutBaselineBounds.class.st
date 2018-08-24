Class {
	#name : #BlGridLayoutBaselineBounds,
	#superclass : #BlGridLayoutBounds,
	#instVars : [
		'size'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridLayoutBaselineBounds >> includeBefore: newBefore after: newAfter [
	super includeBefore: newBefore after: newAfter.
	size := size max: (newBefore + newAfter).
]

{ #category : #accessing }
BlGridLayoutBaselineBounds >> offset: anElement alignment: anAlignment size: aSize [
	^ (super offset: anElement alignment: anAlignment size: aSize) max: 0
]

{ #category : #initialization }
BlGridLayoutBaselineBounds >> reset [
	super reset.
	size := UNDEFINED
]

{ #category : #accessing }
BlGridLayoutBaselineBounds >> size: min [
	^ (super size: min) max: size
]
