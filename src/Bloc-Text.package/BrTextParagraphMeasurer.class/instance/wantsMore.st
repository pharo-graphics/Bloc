measurement - testing
wantsMore
	"Return true if I there is enough space left or there are still not measured glyphs in a text run,
	false otherwise"
	<return: #Boolean>
	
	^ self start <= self length and: [ self availableWidth > 0 ]