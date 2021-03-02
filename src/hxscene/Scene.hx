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
        this.drawLayer = 0;
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
	 * @param cueName The name of the cue being called.
	 * @param userData Additional data to pass to the cue function.
	 * @param director Reference to the invoking director.
	 */
	public function signalCue(cueName:String, userData:Any, ?director:IDirectorable = null):Void {
        if (cueName == null) {
            return;
        }
        // Call cue to all dircetors
        for (director in this.directors) {
            director.signalCue(cueName, userData);
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
	 * Scenes don't use draw layers, as they are omnipotent beings.
	 */
	public var drawLayer:Int;

	/**
	 * The current visibility state of the scene.
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
        if (this.visible == false) {
            return;
        }
        // Draw all visible actors, which should already be in drawLayer ordering.
        for (actor in this.actors) {
            if (actor.isVisible()) {
                actor.draw();
            }
        }
    }



    // public function addActor(actor:IActorable):Void;

    // public function addDirector(director:IDirectorable):Void;




	
    // // actors[draw layer][actor instace]
    // public var actors:IntMap<Array<Actorable>>;
    
    // public var _drawLayers:Array<Int>;
    
    // public var cues:Array<ActorCue>;
    // // public var mCues:IntMap<Array<MouseCue>>;
    // // public var _mCueLayers:Array<Int>;
	// public var id:Int;
    // public var stage:Stage;
    // // public var mouseOverCues:IntMap<Array<MouseCue>>;
    // // public var _mouseOverLayers:Array<Int>;

	// /**
	//  * Default constructor.
	//  */
	// public function new() {
	// 	this.actors = new Map<Int, Array<Actor>>();
    //     this._drawLayers = new Array<Int>();
    //     this.cues = new Array<ActorCue>();
    //     // this.mCues = new Array<MouseCue>();
    //     this.id = -1;
    //     this.stage = null;
    //     // this.mouseOverCues = [];
    //     // this.mouseOverLayers = [];
	// }

	// public function _setAsCurrent() {
    //     // Clear cues
    //     this.cues = [];
    //     // Configure all actors
    //     var actorId = 0;
    //     for (drawLayerActors in this.actors) {
    //         for (actor in drawLayerActors) {
    //             actorId++;
    //             actor._setScene(actorId, this);
    //         }
    //     }
    // }

    // public function _clearDirectorActors(director:Director) {
    //     // First pass to determine what actors should be marked for removal.
    //     var markedForRemoval = new IntMap<Array<Int>>();
    //     for (drawLayer in this.actors.keys()) {
    //         var drawLayerActors = this.actors.get(drawLayer);
    //         for (actorIndex in 0...drawLayerActors.length) {
    //             var actor = drawLayerActors[drawLayer];
    //             if (actor.director != director) {
    //                 continue;
    //             }
    //             // Mark for removal
    //             if (markedForRemoval.get(drawLayer) == null) {
    //                 markedForRemoval.set(drawLayer, new Array<Int>());
    //             }
    //             var drawLayerRemovals = markedForRemoval.get(drawLayer);
    //             drawLayerRemovals.push(actorIndex);
    //         }
    //     }
    //     // Second pass to remove all marked for removal.
    //     for (drawLayer in markedForRemoval.keys()) { 
    //         var drawLayerActorIndexesToRemove = markedForRemoval.get(drawLayer);
    //         var drawLayerActors = this.actors.get(drawLayer);
    //         for (actorIndex in drawLayerActorIndexesToRemove) {
    //             drawLayerActors.splice(actorIndex, 1);
    //         }
    //     }
    // }

    // public function addActor(actor:Actor) {
    //     // Add the actor to the scene.
    //     if (this.actors.get(actor.drawLayer) == null) {
    //         this.actors.set(actor.drawLayer, new Array<Actor>());
    //     }
    //     this.actors.get(actor.drawLayer).push(actor);
    //     // Sort draw layers so that draw ordering follows the painters algorithm.
    //     // I.E. Lowest layer drawn first and ascending draw order to greatest value layer.
    //     var orderedDrawLayers = new Array<Int>();
    //     for (drawLayer in this.actors.keys()) {
    //         orderedDrawLayers.push(drawLayer);
    //     }
    //     orderedDrawLayers.sort(function(layerA:Int, layerB:Int) {
    //         return layerA - layerB;
    //     });
    //     this._drawLayers = orderedDrawLayers;
    // }

    // public function addDirector(director:Director) {
    //     this.addActor(director);
    // }

    // // public function _addMouseCue(watch:MouseCue) {
    // //     // Add mouse cue to the scene.
    // //     if (this.mCues.get(watch.obj.drawLayer) == null) {
    // //         this.mCues.set(watch.obj.drawLayer, new Array<MouseCue>());
    // //     }
    // //     this.mCues.get(watch.obj.drawLayer).push(watch);
    // //     // Sort mouse watch layers, where mouse detection works from forefround to background,
    // //     // thus in reverse order to painters algorithm.
    // //     var orderedDrawLayers = new Array<Int>();
    // //     for (drawLayer in this.mCues.keys()) {
    // //         orderedDrawLayers.push(drawLayer);
    // //     }
    // //     orderedDrawLayers.sort(function(layerA:Int, layerB:Int) {
    // //         return layerB - layerA;
    // //     });
    // //     this._mCueLayers = orderedDrawLayers;
    // // }

    // // public function _addMouseOverCue(watch:MouseCue) {
    // //     // Add mouse cue to the scene.
    // //     if (this.mouseOverCues.get(watch.obj.drawLayer) == null) {
    // //         this.mouseOverCues.set(watch.obj.drawLayer, new Array<MouseCue>());
    // //     }
    // //     this.mouseOverCues.get(watch.obj.drawLayer).push(watch);
    // //     // Sort mouse watch layers, where mouse detection works from forefround to background,
    // //     // thus in reverse order to painters algorithm.
    // //     var orderedDrawLayers = new Array<Int>();
    // //     for (drawLayer in this.mouseOverCues.keys()) {
    // //         orderedDrawLayers.push(drawLayer);
    // //     }
    // //     orderedDrawLayers.sort(function(layerA:Int, layerB:Int) {
    // //         return layerB - layerA;
    // //     });
    // //     this._mouseOverLayers = orderedDrawLayers;
    // // }

    // public function signalCue(eventName:String, userData:Any) {
    //     _signalCue(eventName, this, userData);
    // }

    // public function _signalCue(eventName:String, obj:Any, userData:Any) {
    //     for (cue in this.cues) {
    //         if (cue.cue == eventName && (cue.dir == null || (cue.dir.isActive() && cue.dir == obj))) {
    //             Reflect.callMethod(cue.obj, Reflect.field(cue.obj, cue.cb), [userData]);
    //         }
    //     }
    // }

    // // public function signalMouseCue(target:Any, x:Int, y:Int, isTap:Bool) {
    // //     // Traverse from foreground to background draw layer order of actors.
    // //     for (drawLayer in this._mCueLayers) {
    // //         for (m in this.mCues.get(drawLayer)) {
    // //             // Check if there is a "hit" within the mouse cue hit region
    // //             if (m.r.x <= x && x <= (m.r.x + m.r.w) && m.r.y <= y && y <= (m.r.y + m.r.h)) {
    // //                 var shouldStop = Reflect.callMethod(m.obj, Reflect.field(m.obj, m.cb), [m.obj, target, x, y, isTap]);
    // //                 if (shouldStop) {
    // //                     return;
    // //                 }
    // //             }
    // //         }
    // //     }
    // // }

    // public function load() {
    //     for (drawLayerActors in this.actors) {
    //         for (actor in drawLayerActors) {
    //             actor.load();
    //         }
    //     }
    // }

    // // public function _mouseOverUpdate(dt:Float, mx:Int, my:Int) {
    // //     // Mouse over.
    // //     for (n in this._mouseOverLayers) {
    // //         for (m in this.mouseOverCues.get(n)) {
    // //             if (m.r.x <= mx && mx <= (m.r.x + m.r.w) && m.r.y <= my && my <= (m.r.y + m.r.h)) {
    // //                 var shouldStop = Reflect.callMethod(m.obj, Reflect.field(m.obj, m.cb), [m.obj, dt, mx, my]);
    // //                 if (shouldStop) {
    // //                     return;
    // //                 }
    // //             }
    // //         }
    // //     }
    // // }

    // public function update(dt:Float) {
    //     // Actor updates
    //     for (v in this.actors) {
    //         for (a in v) {
    //             a._doUpdate(dt);
    //         }
    //     }
    // }

    // public function draw() {
    //     // Painters algorithm for draw order.
    //     for (k in this._drawLayers) {
    //         for (a in this.actors.get(k)) {
    //             a._doDraw();
    //         }
    //     }
    // }
}
