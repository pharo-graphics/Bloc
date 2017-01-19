initialization
updateRectangle: aRectangle
	"hostSpace hostWindow primGetWindow primInvalidateRect: (GdkRectangle fromRect: aRectangle) autoRelease."

	hostSpace hostWindow primGetWindow queueDrawArea: aRectangle