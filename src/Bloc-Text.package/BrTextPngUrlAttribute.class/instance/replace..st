accessing
replace: aBrText
	"Return a collection of objects (may be empty) that should replace a provided text piece"
	<return: #SequenceableCollection of: #Character or: #Object>
	| aForm |
	
	aForm := Form fromFileNamed: (self url ifNil: [ aBrText  ]) asString asZnUrl asFileReference.
	self extent ifNotNil: [ aForm := aForm scaledToSize: self extent ].
	
	^ self append
		ifTrue: [ { aBrText . aForm } ]
		ifFalse: [ aForm ]