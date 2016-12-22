private
countLines: aSpText
	| aLinesCount aRope aLineIterator |

	aLinesCount := 0.
	aRope := aSpText rope.
	aLineIterator := aRope iterator: 1 to: aRope size.
	
	[ aLineIterator hasNext ] whileTrue: [ 
		aLineIterator nextLine.
		aLinesCount := aLinesCount + 1 ].
	^ aLinesCount