iterator - enumeration
nextSpan
	"Return a next homogeneous text span"
	<return: #BrSpan>
	| theAttributes |
	
	theAttributes := iterator attributes.
	
	^ BrSpan
		text: (BrRopedText rope: iterator nextSpan)
		attributes: theAttributes