examples - haba,cr,cr,haba
habaCrCrHabaRopeIteratorSecondNextLine: anIterator
	<gtExample>
	<dependsOn: #habaCrCrHabaRopeIteratorFirstNextLine:>
	| nextLine |

	self assert: anIterator hasNext.
	self assert: anIterator position equals: 1 + self haba size.
	
	nextLine := anIterator nextLine.
	
	self assert: nextLine collection isEmpty.
	self assert: anIterator position equals: 3 + self haba size.
	self assert: anIterator hasNext.
	
	^ anIterator