Class {
	#name : #BlInfiniteLinearLayoutDirectionEnd,
	#superclass : #BlInfiniteLinearLayoutDirection,
	#category : 'Bloc-Infinite-Layouts-Linear-Utilities'
}

{ #category : #testing }
BlInfiniteLinearLayoutDirectionEnd >> isEnd [
	^ true
]

{ #category : #testing }
BlInfiniteLinearLayoutDirectionEnd >> isStart [
	^ false
]

{ #category : #converting }
BlInfiniteLinearLayoutDirectionEnd >> multiplier [
	<return: #Number>

	^ 1
]
