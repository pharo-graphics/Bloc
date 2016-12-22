private
lineAt: aNumber
	| aLinesCount aRope aLineIterator aLine |

	aLinesCount := 0.
	aRope := text rope.
	aLineIterator := aRope iterator: 1 to: aRope size.
	aLine := nil.
	
	[ aLineIterator hasNext and: [ aLinesCount < aNumber ] ] whileTrue: [ 
		aLinesCount := aLinesCount + 1.
		aLine := aLineIterator nextLine ].
	
	self assert: [ aLine isNotNil ].
	
	^ aLine