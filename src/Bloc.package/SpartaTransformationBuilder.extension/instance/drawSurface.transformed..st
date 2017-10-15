*Bloc-Core
drawSurface: aSpartaSurface transformed: aMatrix4x4
	"Default implementation does not take 3D transformation matrix into account"
	self canvas fill
		paint: aSpartaSurface;
		path: aSpartaSurface bounds;
		draw