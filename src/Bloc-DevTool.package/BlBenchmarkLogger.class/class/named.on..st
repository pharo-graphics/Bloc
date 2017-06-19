benchmark
named: aSymbol on: aBlock
	| start end coefficient duration |

	start := Time microsecondClockValue.
	aBlock value.
	end := Time microsecondClockValue.
	
	coefficient := 0.1.
	
	duration := self benchmarks
		at: aSymbol
		ifPresent: [ :previous | previous + (((end - start) - previous) * coefficient) ]
		ifAbsent: [ end - start ].
		
	self benchmarks
		at: aSymbol
		put: duration.
	
	BlUniverse default animationManager
		addAnimation: (BlInfinitePostAction on: [ self allInstancesDo: #invalidate ])