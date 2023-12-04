Extension { #name : 'BlPaintBackground' }

{ #category : '*Bloc-Alexandrie' }
BlPaintBackground >> aeApplyTo: aeCanvas [

	self paint aeApplyAsBackgroundTo: aeCanvas opacity: self opacity
]
