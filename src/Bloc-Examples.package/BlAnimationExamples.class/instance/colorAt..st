accessing
colorAt: aDelta
	"Return a Color from a spectrum at a given delta in [0...1]"
	
	^ (BlInfiniteExampleColorsDataSource new colorAt: ((aDelta / 2)+ 0.5) % 1) "darker" alpha: 0.5