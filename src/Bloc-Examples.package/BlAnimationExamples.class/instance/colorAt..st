instance creation
colorAt: aDelta
	"Return a Color from a spectrum at a given delta in [0...1]"
	
	^ BlInfiniteExampleColorsDataSource new colorAt: (aDelta + 0.5) % 1