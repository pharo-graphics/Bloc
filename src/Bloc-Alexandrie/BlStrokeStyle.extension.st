Extension { #name : #BlStrokeStyle }

{ #category : #'*Bloc-Alexandrie' }
BlStrokeStyle >> aeApplyTo: aeCanvas [

	"No dashes is the default"
	self dashArray ifNotEmpty: [ :da | 
		aeCanvas setDashes: da offset: self dashOffset ].

	"Will be valued if geometry has joins"
	aeCanvas setLineJoinBlock: [
		self lineJoin
			aeApplyTo: aeCanvas
			style: self ].

	"Will be valued if geometry is open"
	aeCanvas setLineCapBlock: [
		self lineCap aeApplyTo: aeCanvas ].

]
