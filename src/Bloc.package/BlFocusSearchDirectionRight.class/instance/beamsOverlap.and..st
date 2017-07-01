testing
beamsOverlap: aBlBounds and: anotherBlBounds
	"	
	Beams overlap:
	
	|------------|. . . . . . . . . . . . . . . . . . . . .   (
	|            |
	|  (first)   |...........|---------------|.............   [
	|            |           |               |              
	|____________|. . . . . .|   (another)   |. . . . . . .   )
	                         |               |
	.........................|_______________|.............   ]


	Don't overlap:

   |------------|. . . . . . . . . . . . . . . . . . . . .   (
	|            |
	|  (first)   |
	|            |
	|____________|. . . . . . . . . . . . . . . . . . . . .   )

	
	.........................|---------------|.............   [
	                         |               |              
	                         |   (another)   |
	                         |               |
	.........................|_______________|.............   ]
"
	<return: #Boolean>

	^ anotherBlBounds bottom >= aBlBounds top
		and: [ anotherBlBounds top <= aBlBounds bottom ]