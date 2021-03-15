package hxscene;

/**
 * Stage is the vessel for all the things.
 * The stage is the platform to which scenes, directors, and actors collectively work on.
 */
class Stage implements IStageable {

    private var activeScene:ISceneable;
    private var allScenes:Array<ISceneable>;


    // IEntity

    /**
     * The entity identification value.
     */
    public var id:Int;
    

    /**
	 * Default constructor.
	 */
	public function new() {
        this.id = -1;
        this.activeScene = null;
        this.allScenes = new Array<ISceneable>();
	}


    // IStageable

    /**
     * List of all scenes.
     * 
     * @return Array of scenes that have been add to this stage.
     */
    public function scenes():Array<ISceneable> {
        return this.allScenes;
    }

    /**
     * Add a scene to the stage.
     * 
     * @param scene Reference to the scene.
     */
    public function addScene(scene:ISceneable):Void {
        if (scene == null || this.allScenes.contains(scene)) {
            return;
        }
        this.allScenes.push(scene);
    }
 
    /**
     * Remove a scene from the stage.
     * 
     * @param scene Reference to the scene.
     */
    public function removeScene(scene:ISceneable):Void {
        this.allScenes.remove(scene);
    }
 
    /**
     * Sets a scene as the active scene.
     * @param scene Reference to the scene, which must also be in registered in this Stage class instance. 
     */
    public function setCurrentScene(scene:ISceneable):Void {
        if (scene == null || this.allScenes.contains(scene) == false) {
            return;
        }
        // Deactivate current scene
        if (this.activeScene != null) {
            this.activeScene.setActive(false);
            this.activeScene.setVisible(false);
        }
        this.activeScene = scene;
        this.activeScene.setActive(true);
        this.activeScene.setVisible(true);
    }
 
    /**
     * Reference to the currently active scene.
     * 
     * @return ISceneable reference of the currently active scene.
     */
    public function currentScene():ISceneable {
        return this.activeScene;
    }


    // IUpdateable

    /**
	 * Stage is always active.
	 * 
	 * @return `true`
	 */
	public function isActive():Bool {
        return true;
    }

	/**
	 * Stage active cannot be changed, as it is always active.
	 * 
	 * @param active Is ignored.
	 */
	public function setActive(active:Bool):Void {
    }

	/**
	 * Update logic for the Stage. Ideal for the change of state or AI specific logic.
	 * 
	 * @param dt Time elapsed since last frame, normalized.
	 */
	public function update(dt:Float):Void {
        if (this.activeScene == null) {
            return;
        }
        // Update the active scene.
        this.activeScene.update(dt);
    }


    // IDrawable

    /**
	 * Stage doesn't have a draw order. Calling this method will always return 0.
	 */
	public function drawLayerValue():Int {
		return 0;
	}

	/**
	 * Stage doesn't have a draw order. Calling this method will do nothing.
	 * 
	 * @param drawLayer The new draw layer to move the drawable entity to.
	 */
	public function changeDrawLayer(drawLayer:Int):Void {
	}

	/**
	 * Stage is neither visible or invisible. Calling this method will just return true.
	 * 
	 * @return `true`
	 */
	public function isVisible():Bool {
		return true;
	}

	/**
	 * Stage is neither visible or invisible. Calling this method will do nothing.
	 * 
	 * @param visible Parameter is ignored.
	 */
	public function setVisible(visible:Bool):Void {
	}

	/**
	 * The draw logic of the stage, which will draw the current active scene.
	 */
	public function draw():Void {
        if (this.activeScene == null) {
            return;
        }
		// Draw active scene.
        this.activeScene.draw();
	}

}
