private
pathDataWithin: aBounds
	| scaleFactor translation newPathData |
	scaleFactor := (self extent x isZero or: [ self extent y isZero ])
		ifTrue: [ 1.0 asPoint ]
		ifFalse: [ aBounds extent / self extent ].
	translation := aBounds origin - self position.
	newPathData := self pathData deepCopy.
	newPathData
		do: [ :cmd | 
			cmd second
				withIndexDo: [ :p :i | 
					p isPoint
						ifTrue: [ cmd second at: i put: ((p x * scaleFactor x) @ (p y * scaleFactor y) + translation) asFloatPoint ]
						ifFalse: [ | newP |
							newP := p.
							(cmd first beginsWith: 'h')
								ifTrue: [ newP := (newP * scaleFactor x + translation x) asFloat ]
								ifFalse: [ (cmd first beginsWith: 'v')
										ifTrue: [ newP := (newP * scaleFactor y + translation y) asFloat ] ].
							cmd second at: i put: newP ] ] ].
	^ newPathData