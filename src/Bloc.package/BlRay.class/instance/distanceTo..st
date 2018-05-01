api - vector functions
distanceTo: aPoint
	"The distance (or perpendicular distance) from a point to a line is the shortest distance from a fixed point to any point on a fixed infinite line in Euclidean geometry. It is the length of the line segment which joins the point to the line and is perpendicular to the line.
	(https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line)
	
	Line defined by two points:
	If the line passes through two points P1=(x1,y1) and P2=(x2,y2) then the distance of (x0,y0) from the line is:

	distance = abs( (y2-y1)*x1 - (x2-x1)*y0 + x2*y1 - y2*x1 ) / sqrt( (y2-y1)^2 + (x2-x1)^2 )

	"
	<return: #Number>
	
	self vector isZero
		ifTrue: [ ^ aPoint distanceTo: self point ].
	
	^ ((self vector y * aPoint x) - (self vector x * aPoint y) + (self point y * (self point x + self vector x)) - (self point x * (self point y + self vector y))) abs / self vector length