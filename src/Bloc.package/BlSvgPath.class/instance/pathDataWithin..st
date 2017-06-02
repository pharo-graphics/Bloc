private
pathDataWithin: aBounds
	| scaleFactor  translation newPathData|
	scaleFactor := (self extent x isZero or: [ self extent y isZero ])
		ifTrue: [ 1.0 asPoint ]
		ifFalse: [ aBounds extent / self extent ].
	translation :=  aBounds origin -  self position.
	newPathData := pathData deepCopy.
	newPathData do: [ :cmd | 
			cmd second withIndexDo: [ :p :i | 
				p isPoint 
					ifTrue:[ cmd second at: i put: (((p x * scaleFactor x) @ (p y * scaleFactor y)) + translation) asFloatPoint]
					ifFalse:[ |newV|
						(cmd first beginsWith: 'h') ifTrue:[newV := (p * scaleFactor x + translation x) asFloatPoint].
						(cmd first beginsWith: 'v') ifTrue:[newV := (p * scaleFactor y + translation y) asFloatPoint].
						cmd second at: i put: newV]]].
	^newPathData