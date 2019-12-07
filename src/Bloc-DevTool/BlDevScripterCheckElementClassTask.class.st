Class {
	#name : #BlDevScripterCheckElementClassTask,
	#superclass : #BlDevScripterCheckTask,
	#instVars : [
		'elementClass'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterCheckElementClassTask >> elementClass [
	^ elementClass
]

{ #category : #accessing }
BlDevScripterCheckElementClassTask >> elementClass: anObject [
	elementClass := anObject
]

{ #category : #accessing }
BlDevScripterCheckElementClassTask >> label [
	^ 'Class: ', self elementClass asString
]

{ #category : #actions }
BlDevScripterCheckElementClassTask >> validateOn: anElement [
	self assert: self elementClass isNotNil.
	self assert: anElement class equals: self elementClass.
]
