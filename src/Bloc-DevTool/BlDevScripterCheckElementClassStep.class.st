Class {
	#name : #BlDevScripterCheckElementClassStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'elementClass'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterCheckElementClassStep >> elementClass [
	^ elementClass
]

{ #category : #accessing }
BlDevScripterCheckElementClassStep >> elementClass: anObject [
	elementClass := anObject
]

{ #category : #accessing }
BlDevScripterCheckElementClassStep >> label [
	^ 'Class: ', self elementClass asString
]

{ #category : #actions }
BlDevScripterCheckElementClassStep >> validateOn: anElement [
	self assert: self elementClass isNotNil.
	self assert: anElement class equals: self elementClass.
]
