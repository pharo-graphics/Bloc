private
compact: anArray indices: theIndices
	|size result|
	size := anArray size.
	result := Array new: (theIndices ifEmpty: [ 0 ] ifNotEmpty: #max).
	
	1 to: size do: [ :index | result at: (theIndices at: index) put: (anArray at: index) ].
	^ result