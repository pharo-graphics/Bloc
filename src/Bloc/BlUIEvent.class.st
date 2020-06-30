Class {
	#name : #BlUIEvent,
	#superclass : #BlEvent,
	#instVars : [
		'modifiers'
	],
	#category : #'Bloc-Events'
}

{ #category : #initialization }
BlUIEvent >> initialize [
	super initialize.

	modifiers := BlKeyModifiers new
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
