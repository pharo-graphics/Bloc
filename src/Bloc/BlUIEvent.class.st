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
BlUIEvent >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPut:$(;
		nextPutAll:'; modifiers: ';
		print: modifiers;
		nextPut:$)
]
