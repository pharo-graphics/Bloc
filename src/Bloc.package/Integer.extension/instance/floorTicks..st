*Bloc
floorTicks: aNumber
	"Round me to the tick closest to negative infinity on the scale [0...1] that has aNumber of ticks"
	<return: #Float>
	
	^ self asFloat