accessing
nextWord

	^ self nextSegment: [ :item | item isCharacter and: [ item isSeparator ] ]