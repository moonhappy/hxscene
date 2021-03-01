package hxscene;

/**
 * Actor of a Scene.
 * 
 * An actor is an entity that resembles presence and characterisation. Use the
 * actor construct as the foundation to perform the role of an entity in the game.
 * An actor can also be a simple prop (e.g. inanimate carbon rod was a great actor 
 * in the Simpsons).
 */
class Actor implements IActorable {

	private var scene:ISceneable;
	private var actorCues:Map<String, Array<(Any)->Void>>;
	private var visible:Bool;
	private var active:Bool;
	private var loaded:Bool;

	/**
     * The entity identification value.
     */
	public var id:Int;

	/**
	 * The draw layer specifies the ordering of when to call the object's `draw()` method in the draw cycle, relative to other objects.
	 */
	public var drawLayer:Int;

	/**
     * Reference to the actor's assigned director.
     */
	public var director:IDirectorable;

	/**
	 * Default constructor.
	 * 
	 * @param drawLayer The draw layer the actor will render to.
	 */
	public function new(drawLayer = 0) {
		this.id = -1;
		this.drawLayer = drawLayer;
		this.scene = null;
		this.director = null;
		this.actorCues = new Map<String, Array<(Any)->Void>>();
		this.visible = true;
		this.active = true;
		this.loaded = false;
	}


	// ILoadable

	/**
	 * The current load state of the object.
	 * 
	 * @return If `true` the object has been loaded. That is, successful call of the `load()` method.
	 */
	public function isLoaded():Bool {
		return this.loaded;
	}

	/**
	 * Logic to handle the loading of object specific resources.
	 */
	public function load():Void {
		this.loaded = true;
	}

	/**
     * Logic to handle the release of object resources.
     */
    public function release():Void {
		this.loaded = false;
	}


	// IUpdateable

	/**
	 * Current state of whether the object is active or not. If active, `update()` will be called during the update cycle.
	 * 
	 * @return The current state of whether the object is active or not.
	 */
	public function isActive():Bool {
		return this.active;
	}

	/**
	 * Set the object to be either active or not, which will all `update()` to be called during the update cycle or skipped.
	 * 
	 * @param active Indicate if the object should be active or not.
	 */
	public function setActive(active:Bool):Void {
		this.active = active;
	}

	/**
	 * Update logic for the object. Ideal for the change of state or AI specific logic.
	 * 
	 * @param dt Time elapsed since last frame, normalized.
	 */
	public function update(dt:Float):Void {
		// By default, do nothing in the base class definition for update.
	}

	/**
	 * Internal function for Scene to call. This is so the Actor object respects the `isActive()` state.
	 * 
	 * @param dt Time elapsed since last frame, normalized.
	 */
	public function _doUpdate(dt:Float):Void {
		if (this.active) {
			this.update(dt);
		}
	}


	// IDrawable

	/**
	 * The current visibility state of the object.
	 * 
	 * @return If `true` the object's `draw()` method will be called during the draw cycle, otherwise it will be skipped.
	 */
	public function isVisible():Bool {
		return this.visible;
	}

	/**
	 * Sets whether the object is visible or not. Visible objects will have `draw()` called, otherwise the object will be skipped during draw cycle.
	 * 
	 * @param visible If `true` the object's `draw()` method will be called during the draw cycle, otherwise it will be skipped.
	 */
	public function setVisible(visible:Bool):Void {
		this.visible = visible;
	}

	/**
	 * The draw logic of the object. State should not be altered during the draw logic, as that is better handled by IUpdateable logic.
	 */
	public function draw():Void {
		// By default, do nothing in the base class definition for draw.
	}

	/**
	 * Internal function for Scene to call. This is so the Actor object respects the `isVisible()` state.
	 */
	public function _doDraw():Void {
		if (this.visible) {
			this.draw();
		}
	}


	// ISignalable

	/**
	 * List of registered cues being monitored and the associated callback functions.
	 * 
	 * @return Map of all cues and associated callback functions that are registered.
	 */
	public function cues():Map<String, Array<(Any)->Void>> {
		return this.actorCues;
	}

	/**
	 * Registers a cue for the object to monitor for and act on call.
	 * 
	 * @param cueName The name of the cue.
	 * @param callback Reference to the callback function to invoke when the cue is called.
	 */
	public function registerCue(cueName:String, callback:(Any)->Void):Void {
		// Check params
		if (cueName == null || callback == null) {
			return;
		}
		// Initial state, create new array
		if (this.actorCues.exists(cueName) == false) {
			this.actorCues.set(cueName, [callback]);
			return;
		}
		// Check if cue already registered and cancel if found.
		var cbArray = this.actorCues.get(cueName);
		for (cb in cbArray) {
			if (cb == callback) {
				return;
			}
		}
		// Add to the array.
		cbArray.push(callback);
		// Inform director, for better performance instead of cue signalling needing to check all actors.
		if (this.director != null) {
			this.director.informActorCueRegistered(cueName, this);
		}
	}

	/**
	 * Unregister a cue from the object.
	 * 
	 * @param cueName The name of the cue.
	 * @param callback Reference to the callback function to invoke when the cue is called.
	 */
	public function unregisterCue(cueName:String, callback:(Any)->Void):Void {
		// Check params
		if (cueName == null || callback == null) {
			return;
		}
		// Check if cue already registered and cancel if not.
		var cbArray = this.actorCues.get(cueName);
		if (cbArray == null) {
			return;
		}
		// Find and remove the cue
		cbArray.remove(callback);
		// Inform the director, for better performance.
		if (this.director != null) {
			this.director.informActorCueUnregistered(cueName, this);
		}
	}

	/**
	 * Calls a cue.
	 * 
	 * @param cueName The name of the cue being called.
	 * @param userData Additional data to pass to the cue function.
	 * @param director Reference to the invoking director.
	 */
	public function signalCue(cueName:String, userData:Any, ?director:IDirectorable = null):Void {
		var signals = this.actorCues.get(cueName);
		if (signals == null) {
			return;
		}
		for (cb in signals) {
			cb(userData);
		}
	}

}
