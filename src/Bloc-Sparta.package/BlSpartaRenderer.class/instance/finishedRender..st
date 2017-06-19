renderer - rendering
finishedRender: aSpace
	"Perform neccessary actions after rendering is complete.
	By default I clear dirty areas of a given space"

	aSpace clearDirtyAreas.
	spartaCanvas flush