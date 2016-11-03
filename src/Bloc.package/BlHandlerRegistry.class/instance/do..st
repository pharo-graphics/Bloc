enumerating
do: aBlock 
	self handlers size = 0 ifTrue:[^ self].
	self handlers do: aBlock