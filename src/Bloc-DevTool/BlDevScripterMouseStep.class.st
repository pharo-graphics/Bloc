Class {
	#name : #BlDevScripterMouseStep,
	#superclass : #BlDevScripterStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #'private - accessing' }
BlDevScripterMouseStep >> getMousePositionIn: aScripter [
	^ (aScripter userData includesKey: #mousePosition)
		ifTrue: [ aScripter userData at: #mousePosition ]
		ifFalse: [ 0.0@0.0 ]
]

{ #category : #'private - accessing' }
BlDevScripterMouseStep >> hasMousePositionIn: aScripter [
	^ aScripter userData includesKey: #mousePosition
]

{ #category : #'private - accessing' }
BlDevScripterMouseStep >> setMousePosition: aPoint in: aScripter [
	aScripter userData at: #mousePosition put: aPoint
]
