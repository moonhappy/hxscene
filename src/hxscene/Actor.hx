package hxscene;

/**
 * Actor of a Scene.
 * 
 * An actor is an entity that resembles presence and characterisation. Use the
 * actor construct as the foundation to perform the role of an entity in the game.
 * An actor can also be a simple prop (e.g. inanimate carbon rod was a great actor 
 * in the Simpsons).
 */
class Actor {
	
	public var id:Int;
	public var drawLayer:Int;
	public var scene:Scene;
	public var director:Director;
	public var _visible:Bool;
	public var _active:Bool;
	public var cues:Array<ActorCue>;
	// public var mCues:Array<MouseCue>;
	// public var mouseOverCues:Array<MouseCue>;

	/**
	 * Default constructor.
	 */
	public function new(drawLayer = 0) {
		this.cues = new Array<ActorCue>();
		// this.mCues = new Array<MouseCue>();
		// this.mouseOverCues = new Array<MouseCue>();
		this.id = -1;
		this.drawLayer = drawLayer;
		this.scene = null;
		this.director = null;
		this._visible = true;
		this._active = true;
	}

	public function setActive(active) {
		this._active = active;
	}

	public function isActive():Bool {
		return this._active;
	}

	public function setVisible(visible) {
		this._visible = visible;
	}

	public function isVisible() {
		return this._visible;
	}

	public function onCue(cueName:String, callbackName:String) {
		var newCue = new ActorCue(cueName, callbackName, this, this.director);
		this.cues.push(newCue);
		// TODO:
		// if (this.scene) {
			// var newSceneCue = new ActorCue(cueName, callbackName, this, this.director);
			// this.scene.cues.push(newSceneCue);
		// }
	}

	public function signalCue(cueName:String, userData:Any) {
		// TODO:
		// if (this.scene) {
		// 	this.scene.signalCue(cueName, this, userData);
		// }
	}

	// public function onMouseCue(region:MouseRegion, callbackName:String) {
	// 	var newMouseCue = new MouseCue(region, callbackName, this);
	// 	this.mCues.push(newMouseCue);
	// 	// TODO:
	// 	// if (this.scene) {
	// 		// var newSceneCue = new ActorCue(cueName, callbackName, this, this.director);
	// 		// this.scene.cues.push(newSceneCue);
	// 	// }
	// }

	// public function onMouseOver(region:MouseRegion, callbackName:String) {
	// 	var newMouseOverCue = new MouseCue(region, callbackName, this);
	// 	this.mouseOverCues.push(newMouseOverCue);
	// 	// TODO:
	// 	// if (this.scene) {
	// 		// var newSceneCue = new ActorCue(cueName, callbackName, this, this.director);
	// 		// this.scene.cues.push(newSceneCue);
	// 	// }
	// }

	public function load() { }
	public function update(dt:Float) { }
	public function draw() { }

	public function _doUpdate(dt:Float) {
		if (this._active) {
			update(dt);
		}
	}

	public function _doDraw() {
		if (this._visible) {
			draw();
		}
	}

	public function _setScene(id:Int, scene:Scene) {
		if (scene == null) {
			return;
		}
		// Re-map to scene, if set.
		this.id = id;
		this.scene = scene;
		// Update cues for new scene.
		for (cue in this.cues) {
			if (cue.dir == null) {
				scene.cues.push(cue);
			}
		}
		// // Update mouse cues for new scene.
		// for (mouseCue in this.mCues) {
		// 	scene.addMouseCue(mouseCue);
		// }
		// // Update mouse over cues for new scene.
		// for (mouseOverCue in this.mouseOverCues) {
		// 	scene._addMouseOverCue(mouseOverCue);
		// }
	}
}
