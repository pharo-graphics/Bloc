comparing
closeTo: anotherVector
	^ (self x closeTo: anotherVector x)
		and: [ self y closeTo: anotherVector y ]