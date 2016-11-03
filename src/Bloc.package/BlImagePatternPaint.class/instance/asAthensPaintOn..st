as yet unclassified
asAthensPaintOn: anAthensCanvas
	^ (anAthensCanvas cacheAt: self ifAbsentPut: [ anAthensCanvas surface createFormPaint: form ])
		origin: 0@0;
		yourself