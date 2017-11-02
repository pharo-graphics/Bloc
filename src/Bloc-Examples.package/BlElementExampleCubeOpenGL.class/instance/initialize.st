initialization
initialize
	super initialize.
	
	"ctx := UFFIOpenGLContext new.
	ctx gl
		clearColor_red: 1.0 green: 1 blue: 1.0 alpha: 1;
		clearDepth: 1.0;
		enable: GL_DEPTH_TEST;
		enable: GL_CULL_FACE;
		enable: GL_TEXTURE_2D;
		depthFunc: GL_LEQUAL;
		shadeModel: GL_SMOOTH;
		hint_target: GL_PERSPECTIVE_CORRECTION_HINT mode: GL_NICEST.
	
	rotateX := 0.
	rotateY := 0.
	rotateZ := 0.
	
	BlNumberTransition new
		beInfinite;
		target: self;
		from: 0;
		to: 360;
		duration: 10000;
		onStepDo: [ :value | rotateX := rotateY := rotateZ := value. self invalidate ];
		start.
		
	count := 0"