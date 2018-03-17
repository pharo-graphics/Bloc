children - enumerating
reject: aBlock 
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver only those elements for 
	which aBlock evaluates to false. Answer the new collection."
	<return: #Array of: #BlElement>
	
	^ self select: [ :anElement | (aBlock value: anElement) == false ]