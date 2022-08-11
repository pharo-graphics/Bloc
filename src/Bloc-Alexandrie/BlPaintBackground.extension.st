Extension { #name : #BlPaintBackground }

{ #category : #'*Bloc-Alexandrie' }
BlPaintBackground >> aeApplyTo: aeCanvas [

	self paint aeApplyTo: aeCanvas opacity: self opacity
]
