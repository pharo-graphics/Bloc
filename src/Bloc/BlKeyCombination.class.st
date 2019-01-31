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

{ #category : #'instance creation' }
BlKeyCombination class >> arrowDown [
	^ self builder arrowDown build
]

{ #category : #'instance creation' }
BlKeyCombination class >> arrowLeft [
	^ self builder arrowLeft build
]

{ #category : #'instance creation' }
BlKeyCombination class >> arrowRight [
	^ self builder arrowRight build
]

{ #category : #'instance creation' }
BlKeyCombination class >> arrowUp [
	^ self builder arrowUp build
]

{ #category : #'instance creation' }
BlKeyCombination class >> backspace [
	^ self builder backspace build
]

{ #category : #accessing }
BlKeyCombination class >> builder [
	^ BlKeyCombinationBuilder new
]

{ #category : #'instance creation' }
BlKeyCombination class >> delete [
	^ self builder delete build
]

{ #category : #'instance creation' }
BlKeyCombination class >> escape [
	^ self builder escape build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryA [
	"primary (Command/Control) + A"
	<return: #BlKeyCombination>

	^ self builder primary a build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryB [
	"primary (Command/Control) + B"
	<return: #BlKeyCombination>

	^ self builder primary b build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryC [
	"primary (Command/Control) + C"
	<return: #BlKeyCombination>

	^ self builder primary c build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryD [
	"primary (Command/Control) + D"
	<return: #BlKeyCombination>

	^ self builder primary d build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryE [
	"primary (Command/Control) + E"
	<return: #BlKeyCombination>

	^ self builder primary e build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryF [
	"primary (Command/Control) + F"
	<return: #BlKeyCombination>

	^ self builder primary f build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryG [
	"primary (Command/Control) + G"
	<return: #BlKeyCombination>

	^ self builder primary g build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryM [
	"primary (Command/Control) + M"
	<return: #BlKeyCombination>

	^ self builder primary m build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryN [
	"primary (Command/Control) + N"
	<return: #BlKeyCombination>

	^ self builder primary n build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryP [
	"primary (Command/Control) + P"
	<return: #BlKeyCombination>

	^ self builder primary p build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryR [
	"primary (Command/Control) + R"
	<return: #BlKeyCombination>

	^ self builder primary r build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryS [
	"primary (Command/Control) + S"
	<return: #BlKeyCombination>

	^ self builder primary s build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryShiftF [
	"primary (Command/Control) + Shift + F"
	<return: #BlKeyCombination>

	^ self builder primary shift f build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryV [
	"primary (Command/Control) + V"
	<return: #BlKeyCombination>

	^ self builder primary v build
]

{ #category : #'instance creation' }
BlKeyCombination class >> primaryX [
	"primary (Command/Control) + X"
	<return: #BlKeyCombination>

	^ self builder primary x build
]

{ #category : #'instance creation' }
BlKeyCombination class >> return [
	^ self builder return build
]

{ #category : #'instance creation' }
BlKeyCombination class >> tab [
	^ self builder tab build
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
