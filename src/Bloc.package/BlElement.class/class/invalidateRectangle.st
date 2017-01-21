accessing
invalidateRectangle
	"Return a temporary rectangle used by various #invalidate methods.
	It is a shared singleton to minimize object creation.
	Benchmarks show there might be dozens of thousands invalidation calls per frame where
	each call creates a new instance of rectangle.
	By convention invalidation must happens on UI thread, so at any time there is only one
	rectangle involved in invalidation process. It makes a lot of sense to make it a singleton.
	I must only be used on UI thread! Always make a copy if you want to store this rectangle!"
	<return: #SpartaRectangle>

	^ invalidateRectangle ifNil: [ invalidateRectangle := SpartaRectangle new ]