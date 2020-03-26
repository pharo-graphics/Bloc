"
I contain examples of how to use key combination
"
Class {
	#name : #BlKeyCombinationExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #examples }
BlKeyCombinationExamples class >> keyLogger [
	<gtExample>

	^ BlElement new
		size: 200@200;
		background: Color red;
		addEventHandler: (BlEventHandler on: BlTextInputEvent
			do: [ :anEvent | self inform: 'Text input: ', anEvent text ]);
		addEventHandler: (BlEventHandler on: BlKeyDownEvent
			do: [ :anEvent | self inform: 'Key down: ', anEvent key asString ]);
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder shift; meta; key: BlKeyboardKey arrowLeft; build);
			action: [ :anEvent :aShortcut | self inform: 'Triggered ', aShortcut combination asString ]);
		addShortcut: (BlShortcut new
			combination: (BlSingleKeyCombination key: BlKeyboardKey a);
			action: [ self inform: 'Shortcut: a' ]);
		addShortcut: (BlShortcut new
			combination: (BlSingleKeyCombination key: BlKeyboardKey arrowUp);
			action: [ self inform: 'Shortcut: arrowUp' ]);
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder meta; key: BlKeyboardKey arrowUp; build);
			action: [ self inform: 'Shortcut: meta + arrowUp' ]);
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder shift; meta; key: BlKeyboardKey arrowUp; build);
			action: [ self inform: 'Shortcut: meta + shift + arrowUp' ]);
		requestFocus;
		yourself
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> alternativeCombination [
	<gtExample>
	
	^ BlAlternativeCombination new
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> arrowLeft [
	<gtExample>
	
	^ BlKeyboardKey arrowLeft
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> compulsoryCombination [
	<gtExample>
	
	^ BlCompulsoryCombination new
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> leftMeta [
	<gtExample>
	
	^ BlKeyboardKey metaLeft
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> leftShift [
	<gtExample>
	
	^ BlKeyboardKey shiftLeft
]

{ #category : #examples }
BlKeyCombinationExamples >> meta: aKeyAlternative left: aLeftMeta right: aRightMeta [
	<gtExample>
	<dependsOn: #alternativeCombination>
	<dependsOn: #leftMeta>
	<dependsOn: #rightMeta>
	
	^ aKeyAlternative
		key: aLeftMeta;
		key: aRightMeta;
		yourself
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> rightMeta [
	<gtExample>
	
	^ BlKeyboardKey metaRight
]

{ #category : #'instance creation' }
BlKeyCombinationExamples >> rightShift [
	<gtExample>
	
	^ BlKeyboardKey shiftLeft
]

{ #category : #examples }
BlKeyCombinationExamples >> shift: aShiftAlternative arrowLeft: anArrowLeft and: aCompulsoryCombination [
	<gtExample>
	<dependsOn: #shift:left:right:>
	<dependsOn: #arrowLeft>
	<dependsOn: #compulsoryCombination>
	
	^ aCompulsoryCombination
		with: aShiftAlternative;
		key: anArrowLeft;
		yourself
]

{ #category : #examples }
BlKeyCombinationExamples >> shift: aKeyAlternative left: aLeftShift right: aRightShift [
	<gtExample>
	<dependsOn: #alternativeCombination>
	<dependsOn: #leftShift>
	<dependsOn: #rightShift>
	
	^ aKeyAlternative
		key: aLeftShift;
		key: aRightShift;
		yourself
]
