Class {
	#name : #BlKeyCombinationExamplesDemo,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'instance creation' }
BlKeyCombinationExamplesDemo >> alternativeCombination [
	<gtExample>
	
	^ BlAlternativeCombination new
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesDemo >> arrowLeft [
	<gtExample>
	
	^ KeyboardKey left
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesDemo >> compulsoryCombination [
	<gtExample>
	
	^ BlCompulsoryCombination new
]

{ #category : #'examples - demo' }
BlKeyCombinationExamplesDemo >> keyLogger [

	<sampleInstance>
	^ BlElement new
		  size: 200 @ 200;
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
BlKeyCombinationExamplesDemo >> leftMeta [

	<gtExample>
	^ KeyboardKey metaLeft
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesDemo >> leftShift [

	<gtExample>
	^ KeyboardKey shiftLeft
]

{ #category : #examples }
BlKeyCombinationExamplesDemo >> meta: aKeyAlternative left: aLeftMeta right: aRightMeta [
	
	^ aKeyAlternative
		key: aLeftMeta;
		key: aRightMeta;
		yourself
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesDemo >> rightMeta [

	<gtExample>
	^ KeyboardKey metaRight
]

{ #category : #'instance creation' }
BlKeyCombinationExamplesDemo >> rightShift [

	<gtExample>
	^ KeyboardKey shiftLeft
]

{ #category : #examples }
BlKeyCombinationExamplesDemo >> shift: aShiftAlternative arrowLeft: anArrowLeft and: aCompulsoryCombination [
	
	^ aCompulsoryCombination
		with: aShiftAlternative;
		key: anArrowLeft;
		yourself
]

{ #category : #examples }
BlKeyCombinationExamplesDemo >> shift: aKeyAlternative left: aLeftShift right: aRightShift [
	
	^ aKeyAlternative
		key: aLeftShift;
		key: aRightShift;
		yourself
]
