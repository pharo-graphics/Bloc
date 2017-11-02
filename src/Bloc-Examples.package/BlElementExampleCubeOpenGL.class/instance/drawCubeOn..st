drawing
drawCubeOn: gl
	"| cubeSize |

	cubeSize := self cubeSize.

	self cube do: [ :aSide |
		gl begin: GL_QUADS.
		aSide do: [ :aVertex |			
			gl
				color3f_red: aVertex key first
				green: aVertex key third
				blue: aVertex key fifth.
			gl
				vertex3f_x: aVertex value first
				y: aVertex value third
				z: aVertex value fifth ].
		gl end ]."