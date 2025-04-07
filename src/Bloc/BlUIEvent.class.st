Class {
	#name : #BlUIEvent,
	#superclass : #BlEvent,
	#instVars : [
		'modifiers'
	],
	#category : #'Bloc-Events'
}

{ #category : #converting }
BlUIEvent >> asDictionaryForExport [
	^ super asDictionaryForExport
		at: #modifiers put: modifiers printString;
		yourself
]

{ #category : #initialization }
BlUIEvent >> initialize [
	super initialize.

	modifiers := BlKeyModifiers new
]

{ #category : #testing }
BlUIEvent >> isUIEvent [
	^ true
]

{ #category : #accessing }
BlUIEvent >> modifiers [
	<return: #BlKeyModifiers>

	^ modifiers
]

{ #category : #accessing }
BlUIEvent >> modifiers: aBlKeyModifiers [
	 modifiers := aBlKeyModifiers
]

{ #category : #printing }
BlUIEvent >> printExtraDetailsOn: aStream [

	super printExtraDetailsOn: aStream.
	
	modifiers isEmpty ifFalse: [
		aStream
			nextPutAll: ' modifiers: ';
			print: modifiers ]
]
