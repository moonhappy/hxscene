package hxscene;

import haxe.macro.Expr.Catch;
import haxe.ds.IntMap;

/**
 * A scene.
 * 
 * The scene contains an assortment of actors and directors.
 */
class Scene implements ISceneable {

    private var active:Bool;
    private var visible:Bool;
    private var actors:Array<IActorable>;
    private var directors:Array<IDirectorable>;

    /**
	 * Default constructor.
	 */
	public function new() {
        this.id = -1;
        this.active = false;
        this.visible = false;
        this.actors = new Array<IActorable>();
        this.directors = new Array<IDirectorable>();
	}


    // IEntity

    /**
     * The entity identification value.
     */
    public var id:Int;


    // ISceneable

    /**
     * Add an actor to the scene.
     * 
     * @param actor Reference to the actor.
     */
    public function addActor(actor:IActorable):Void {
        if (actor == null || this.actors.contains(actor)) {
            return;
        }
        this.actors.push(actor);
        actor.scene = this;
        refreshDrawOrder();
    }

     /**
      * Remove an actor from the scene.
      * 
      * @param actor Reference to the actor.
      */
    public function removeActor(actor:IActorable):Void {
        this.actors.remove(actor);
        actor.scene = null;
    }
 
     /**
      * Add a director to the scene.
      * 
      * @param director Reference to the director.
      */
    public function addDirector(director:IDirectorable):Void {
        if (director == null || this.directors.contains(director)) {
            return;
        }
        this.directors.push(director);
    }
 
     /**
      * Remove a director from the scene.
      * 
      * @param director Reference to the director.
      */
    public function removeDirector(director:IDirectorable):Void {
        this.directors.remove(director);
    }

    /**
     * If draw layer of one or more entities changes, the scene should be informed to
     * resort the registered entites to make the draw layers render in the correct order.
     * This will be automatically called by Actor instances when the draw-layer is modified.
     */
     public function refreshDrawOrder():Void {
         // Sort by draw layer
        this.actors.sort((a1, a2) -> a1.drawLayerValue() - a2.drawLayerValue());
     }


    // ISignalable

	/**
	 * Calls a cue. The scene will inform all directors of the cue being signalled.
	 * 
	 * @param cueID The unique ID of the cue.
	 * @param userData Additional data to pass to the cue function.
	 * @param director Reference to the invoking director.
	 */
	public function signalCue(cueID:Int, userData:Any, ?director:IDirectorable = null):Void {
        // Call cue to all dircetors
        for (director in this.directors) {
            director.signalCue(cueID, userData);
        }
    }


    // ILoadable

    /**
	 * The current load state of the scene.
	 * 
	 * @return If `true` the object has been loaded. That is, successful call of the `load()` method.
	 */
	public function isLoaded():Bool {
        // Check if all actors are loaded
        for (actor in this.actors) {
            if (actor.isLoaded() == false) {
                return false;
            }
        }
        // All is loaded, yay!
        return true;
    }

	/**
	 * Logic to handle the loading of object specific resources.
	 */
	public function load():Void {
        // Load all actors
        for (actor in this.actors) {
            if (actor.isLoaded()) {
                continue;
            }
            actor.load();
        }
    }

    /**
     * Logic to handle the release of object resources.
     */
    public function release():Void {
        // Release all actors
        for (actor in this.actors) {
            if (actor.isLoaded() == false) {
                continue;
            }
            actor.release();
        }
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
        if (this.active == false) {
            return;
        }
        // Update all actors
        for (actor in this.actors) {
            if (actor.isActive()) {
                actor.update(dt);
            }
        }
    }


    // IDrawable

    /**
	 * Scene's don't have a draw order. Calling this method will always return 0.
	 */
	public function drawLayerValue():Int {
		return 0;
	}

	/**
	 * Scene's don't have a draw order. Calling this method will do nothing.
	 * 
	 * @param drawLayer The new draw layer to move the drawable entity to.
	 */
	public function changeDrawLayer(drawLayer:Int):Void {
	}

	/**
	 * Scenes are neither visible or invisible. Calling this method will just return true.
	 * 
	 * @return `true`
	 */
	public function isVisible():Bool {
		return true;
	}

	/**
	 * Scenes are neither visible or invisible. Calling this method will do nothing.
	 * 
	 * @param visible Parameter is ignored.
	 */
	public function setVisible(visible:Bool):Void {
	}

	/**
	 * The draw logic of the scene.
	 */
	public function draw():Void {
		// Draw all visible actors, which should already be in drawLayer ordering.
        for (actor in this.actors) {
            if (actor.isVisible()) {
                actor.draw();
            }
        }
	}

}
