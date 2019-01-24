"
I represent an abstract key combination which is the most important part of ===BlShortcut===.
I define an event matching API that allows ===BlShortcutHandler=== to find the most appropriate shortcut for currently pressed keys.

I have support of Visitor pattern. See ===BlKeyCombinationVisitor===

See ===BlKeyCombinationExamples=== for related examples.
"
Class {
	#name : #BlKeyCombination,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlKeyCombination class >> builder [
	^ BlKeyCombinationBuilder new
]

{ #category : #visiting }
BlKeyCombination >> accept: aKeyCombinationVisitor [
	^ self subclassResponsibility
]

{ #category : #'key matching' }
BlKeyCombination >> includes: aKey [
	^ self subclassResponsibility
]

{ #category : #testing }
BlKeyCombination >> isAlternative [
	^ false
]

{ #category : #testing }
BlKeyCombination >> isCompulsory [
	^ false
]

{ #category : #'key matching' }
BlKeyCombination >> match: aKeyboardBuffer [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'key matching' }
BlKeyCombination >> matches: aKeyboardBuffer [
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #controlling }
BlKeyCombination >> or: anotherKeyCombination [
	<return: #BlKeyCombination>

	^ BlAlternativeCombination new
		with: self;
		with: anotherKeyCombination
]
