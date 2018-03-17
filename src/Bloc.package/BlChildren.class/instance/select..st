children - enumerating
select: aBlock 
	"Evaluate aBlock with each of the receiver's elements as the argument. 
	Collect into a new collection like the receiver, only those elements for 
	which aBlock evaluates to true. Answer the new collection."
	<return: #Array of: #BlElement>
	
	^ Array streamContents: [ :aStream |
			self do: [ :anElement |
				(aBlock value: anElement)
					ifTrue: [ aStream nextPut: anElement ] ] ]