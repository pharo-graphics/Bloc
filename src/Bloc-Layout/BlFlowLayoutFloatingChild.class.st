Class {
	#name : #BlFlowLayoutFloatingChild,
	#superclass : #BlFlowLayoutChild,
	#instVars : [
		'lines'
	],
	#package : 'Bloc',
	#tag : 'Layout-Flow-Utilities'
}

{ #category : #adding }
BlFlowLayoutFloatingChild >> addToLine: aLine [
	
	"Only add me to the first line"
	self lines ifEmpty: [ 
		(self orientation isHorizontal and: [ self direction isRightToLeft ])
			ifTrue: [ aLine addFloatFirst: self ]
			ifFalse: [ aLine addFloatLast: self ] ].
	lines add: aLine
]

{ #category : #geometry }
BlFlowLayoutFloatingChild >> excessBreadth [
	^ self totalBreadth - (self lines inject: 0 into: [ :aTotalBreadth :aLine | aTotalBreadth + aLine breadth ] )
]

{ #category : #initialization }
BlFlowLayoutFloatingChild >> initialize [
	super initialize.
	
	lines := OrderedCollection new
]

{ #category : #accessing }
BlFlowLayoutFloatingChild >> lastLine [
	^ lines last
]

{ #category : #accessing }
BlFlowLayoutFloatingChild >> lines [
	^ lines
]
