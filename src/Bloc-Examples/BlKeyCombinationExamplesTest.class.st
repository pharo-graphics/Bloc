"
I contain examples of how to use key combination

"
Class {
	#name : #BlKeyCombinationExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'instance creation' }
BlKeyCombinationExamplesTest >> alternativeCombination [

	<sampleInstance>
	^ BlAlternativeCombination new
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesTest >> arrowLeft [

	<sampleInstance>
	^ KeyboardKey left
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesTest >> compulsoryCombination [

	<sampleInstance>
	^ BlCompulsoryCombination new
]

{ #category : #examples }
BlKeyCombinationExamplesTest >> keyLogger [

	<sampleInstance>
	<demo>
	^ BlElement new
		  extent: 200 @ 200;
		  background: Color red;
		  addEventHandler: (BlEventHandler
				   on: BlTextInputEvent
				   do: [ :anEvent | self inform: 'Text input: ' , anEvent text ]);
		  addEventHandler: (BlEventHandler
				   on: BlKeyDownEvent
				   do: [ :anEvent |
					   self inform: 'Key down: ' , anEvent key asString ]);
		  addShortcut: (BlShortcutWithAction new
				   combination: (BlKeyCombination builder
						    shift;
						    meta;
						    key: KeyboardKey left;
						    build);
				   action: [ :anEvent :aShortcut |
					   self inform: 'Triggered ' , aShortcut combination asString ]);
		  addShortcut: (BlShortcutWithAction new
				   combination: (BlSingleKeyCombination key: KeyboardKey A);
				   action: [ self inform: 'Shortcut: a' ]);
		  addShortcut: (BlShortcutWithAction new
				   combination: (BlSingleKeyCombination key: KeyboardKey up);
				   action: [ self inform: 'Shortcut: arrowUp' ]);
		  addShortcut: (BlShortcutWithAction new
				   combination: (BlKeyCombination builder
						    meta;
						    key: KeyboardKey up;
						    build);
				   action: [ self inform: 'Shortcut: meta + arrowUp' ]);
		  addShortcut: (BlShortcutWithAction new
				   combination: (BlKeyCombination builder
						    shift;
						    meta;
						    key: KeyboardKey up;
						    build);
				   action: [ self inform: 'Shortcut: meta + shift + arrowUp' ]);
		  requestFocus;
		  yourself
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesTest >> leftMeta [

	<sampleInstance>
	^ KeyboardKey metaLeft
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesTest >> leftShift [

	<sampleInstance>
	^ KeyboardKey shiftLeft
]

{ #category : #examples }
BlKeyCombinationExamplesTest >> meta: aKeyAlternative left: aLeftMeta right: aRightMeta [
	
	^ aKeyAlternative
		key: aLeftMeta;
		key: aRightMeta;
		yourself
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesTest >> rightMeta [

	<sampleInstance>
	^ KeyboardKey metaRight
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesTest >> rightShift [

	<sampleInstance>
	^ KeyboardKey shiftLeft
]

{ #category : #examples }
BlKeyCombinationExamplesTest >> shift: aShiftAlternative arrowLeft: anArrowLeft and: aCompulsoryCombination [
	
	^ aCompulsoryCombination
		with: aShiftAlternative;
		key: anArrowLeft;
		yourself
]

{ #category : #examples }
BlKeyCombinationExamplesTest >> shift: aKeyAlternative left: aLeftShift right: aRightShift [
	
	^ aKeyAlternative
		key: aLeftShift;
		key: aRightShift;
		yourself
]
