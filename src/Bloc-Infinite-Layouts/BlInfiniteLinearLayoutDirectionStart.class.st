Class {
	#name : #BlInfiniteLinearLayoutDirectionStart,
	#superclass : #BlInfiniteLinearLayoutDirection,
	#category : 'Bloc-Infinite-Layouts-Linear-Utilities'
}

{ #category : #testing }
BlInfiniteLinearLayoutDirectionStart >> isEnd [
	^ false
]

{ #category : #testing }
BlInfiniteLinearLayoutDirectionStart >> isStart [
	^ true
]

{ #category : #converting }
BlInfiniteLinearLayoutDirectionStart >> multiplier [
	<return: #Number>

	^ -1
]
