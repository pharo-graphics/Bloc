*Bloc-Core
drawSurface: aSpartaSurface transformed: aMatrix3D
	| anArray isSuccess |

	anArray := FFIExternalArray externalNewType: 'float' size: 16.
	
	anArray at: 1 put: aMatrix3D sx.
	anArray at: 2 put: aMatrix3D shy0.
	anArray at: 3 put: aMatrix3D shz0.
	anArray at: 4 put: aMatrix3D wx.
	anArray at: 5 put: aMatrix3D shx0.
	anArray at: 6 put: aMatrix3D sy.
	anArray at: 7 put: aMatrix3D shz1.
	anArray at: 8 put: aMatrix3D wy.
	anArray at: 9 put: aMatrix3D shx1.
	anArray at: 10 put: aMatrix3D shy1.
	anArray at: 11 put: aMatrix3D sz.
	anArray at: 12 put: aMatrix3D wz.
	anArray at: 13 put: aMatrix3D x.
	anArray at: 14 put: aMatrix3D y.
	anArray at: 15 put: aMatrix3D z.
	anArray at: 16 put: aMatrix3D w.
	
	isSuccess := self primDrawSurface: aSpartaSurface matrix: anArray getHandle.
	
	anArray free