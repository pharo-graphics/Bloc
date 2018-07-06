iterator - enumeration
nextSpan
	"Return a next homogeneous text span"
	<return: #BlSpan>
	| theAttributes |
	
	theAttributes := iterator attributes.
	
	^ BlSpan
		text: (BlRopedText rope: iterator nextSpan)
		attributes: theAttributes