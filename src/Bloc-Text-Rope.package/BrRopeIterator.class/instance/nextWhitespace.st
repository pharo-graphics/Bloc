accessing
nextWhitespace

	^ self nextSegment: [ :item | item isCharacter not or: [ item isSeparator not ] ]