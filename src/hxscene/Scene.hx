package hxscene;

import haxe.ds.IntMap;

/**
 * A scene.
 * 
 * The scene contains an assortment of actors.
 */
class Scene {
	
    public var actors:IntMap<Array<Actor>>;
    public var _drawLayers:Array<Int>;
    public var cues:Array<ActorCue>;
    // public var mCues:IntMap<Array<MouseCue>>;
    // public var _mCueLayers:Array<Int>;
	public var id:Int;
    public var stage:Stage;
    // public var mouseOverCues:IntMap<Array<MouseCue>>;
    // public var _mouseOverLayers:Array<Int>;

	/**
	 * Default constructor.
	 */
	public function new() {
		this.actors = new Map<Int, Array<Actor>>();
        this._drawLayers = new Array<Int>();
        this.cues = new Array<ActorCue>();
        // this.mCues = new Array<MouseCue>();
        this.id = -1;
        this.stage = null;
        // this.mouseOverCues = [];
        // this.mouseOverLayers = [];
	}

	public function _setAsCurrent() {
        // Clear cues
        this.cues = [];
        // Configure all actors
        var actorId = 0;
        for (drawLayerActors in this.actors) {
            for (actor in drawLayerActors) {
                actorId++;
                actor._setScene(actorId, this);
            }
        }
    }

    public function _clearDirectorActors(director:Director) {
        // First pass to determine what actors should be marked for removal.
        var markedForRemoval = new IntMap<Array<Int>>();
        for (drawLayer in this.actors.keys()) {
            var drawLayerActors = this.actors.get(drawLayer);
            for (actorIndex in 0...drawLayerActors.length) {
                var actor = drawLayerActors[drawLayer];
                if (actor.director != director) {
                    continue;
                }
                // Mark for removal
                if (markedForRemoval.get(drawLayer) == null) {
                    markedForRemoval.set(drawLayer, new Array<Int>());
                }
                var drawLayerRemovals = markedForRemoval.get(drawLayer);
                drawLayerRemovals.push(actorIndex);
            }
        }
        // Second pass to remove all marked for removal.
        for (drawLayer in markedForRemoval.keys()) { 
            var drawLayerActorIndexesToRemove = markedForRemoval.get(drawLayer);
            var drawLayerActors = this.actors.get(drawLayer);
            for (actorIndex in drawLayerActorIndexesToRemove) {
                drawLayerActors.splice(actorIndex, 1);
            }
        }
    }

    public function addActor(actor:Actor) {
        // Add the actor to the scene.
        if (this.actors.get(actor.drawLayer) == null) {
            this.actors.set(actor.drawLayer, new Array<Actor>());
        }
        this.actors.get(actor.drawLayer).push(actor);
        // Sort draw layers so that draw ordering follows the painters algorithm.
        // I.E. Lowest layer drawn first and ascending draw order to greatest value layer.
        var orderedDrawLayers = new Array<Int>();
        for (drawLayer in this.actors.keys()) {
            orderedDrawLayers.push(drawLayer);
        }
        orderedDrawLayers.sort(function(layerA:Int, layerB:Int) {
            return layerA - layerB;
        });
        this._drawLayers = orderedDrawLayers;
    }

    public function addDirector(director:Director) {
        this.addActor(director);
    }

    // public function _addMouseCue(watch:MouseCue) {
    //     // Add mouse cue to the scene.
    //     if (this.mCues.get(watch.obj.drawLayer) == null) {
    //         this.mCues.set(watch.obj.drawLayer, new Array<MouseCue>());
    //     }
    //     this.mCues.get(watch.obj.drawLayer).push(watch);
    //     // Sort mouse watch layers, where mouse detection works from forefround to background,
    //     // thus in reverse order to painters algorithm.
    //     var orderedDrawLayers = new Array<Int>();
    //     for (drawLayer in this.mCues.keys()) {
    //         orderedDrawLayers.push(drawLayer);
    //     }
    //     orderedDrawLayers.sort(function(layerA:Int, layerB:Int) {
    //         return layerB - layerA;
    //     });
    //     this._mCueLayers = orderedDrawLayers;
    // }

    // public function _addMouseOverCue(watch:MouseCue) {
    //     // Add mouse cue to the scene.
    //     if (this.mouseOverCues.get(watch.obj.drawLayer) == null) {
    //         this.mouseOverCues.set(watch.obj.drawLayer, new Array<MouseCue>());
    //     }
    //     this.mouseOverCues.get(watch.obj.drawLayer).push(watch);
    //     // Sort mouse watch layers, where mouse detection works from forefround to background,
    //     // thus in reverse order to painters algorithm.
    //     var orderedDrawLayers = new Array<Int>();
    //     for (drawLayer in this.mouseOverCues.keys()) {
    //         orderedDrawLayers.push(drawLayer);
    //     }
    //     orderedDrawLayers.sort(function(layerA:Int, layerB:Int) {
    //         return layerB - layerA;
    //     });
    //     this._mouseOverLayers = orderedDrawLayers;
    // }

    public function signalCue(eventName:String, userData:Any) {
        _signalCue(eventName, this, userData);
    }

    public function _signalCue(eventName:String, obj:Any, userData:Any) {
        for (cue in this.cues) {
            if (cue.cue == eventName && (cue.dir == null || (cue.dir.isActive() && cue.dir == obj))) {
                Reflect.callMethod(cue.obj, Reflect.field(cue.obj, cue.cb), [userData]);
            }
        }
    }

    // public function signalMouseCue(target:Any, x:Int, y:Int, isTap:Bool) {
    //     // Traverse from foreground to background draw layer order of actors.
    //     for (drawLayer in this._mCueLayers) {
    //         for (m in this.mCues.get(drawLayer)) {
    //             // Check if there is a "hit" within the mouse cue hit region
    //             if (m.r.x <= x && x <= (m.r.x + m.r.w) && m.r.y <= y && y <= (m.r.y + m.r.h)) {
    //                 var shouldStop = Reflect.callMethod(m.obj, Reflect.field(m.obj, m.cb), [m.obj, target, x, y, isTap]);
    //                 if (shouldStop) {
    //                     return;
    //                 }
    //             }
    //         }
    //     }
    // }

    public function load() {
        for (drawLayerActors in this.actors) {
            for (actor in drawLayerActors) {
                actor.load();
            }
        }
    }

    // public function _mouseOverUpdate(dt:Float, mx:Int, my:Int) {
    //     // Mouse over.
    //     for (n in this._mouseOverLayers) {
    //         for (m in this.mouseOverCues.get(n)) {
    //             if (m.r.x <= mx && mx <= (m.r.x + m.r.w) && m.r.y <= my && my <= (m.r.y + m.r.h)) {
    //                 var shouldStop = Reflect.callMethod(m.obj, Reflect.field(m.obj, m.cb), [m.obj, dt, mx, my]);
    //                 if (shouldStop) {
    //                     return;
    //                 }
    //             }
    //         }
    //     }
    // }

    public function update(dt:Float) {
        // Actor updates
        for (v in this.actors) {
            for (a in v) {
                a._doUpdate(dt);
            }
        }
    }

    public function draw() {
        // Painters algorithm for draw order.
        for (k in this._drawLayers) {
            for (a in this.actors.get(k)) {
                a._doDraw();
            }
        }
    }
}
