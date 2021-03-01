package hxscene;

/**
 * Director to boss actors around.
 * 
 * The director is like an actor, but is behind the scenes making sure everything
 * goes to "plan". But directors can be actors.
 */
class Director extends Actor implements IDirectorable {

    private var actors:Array<IActorable>;
    private var registeredCues:Map<String, Array<IActorable>>;

    /**
	 * Default constructor. By default, directors are not visible.
	 * 
	 * @param drawLayer The draw layer the actor will render to.
	 */
	public function new(drawLayer = 0) {
        super(drawLayer);
        this.actors = new Array<IActorable>();
        this.registeredCues = new Map<String, Array<IActorable>>();
        this.visible = false;
        addActor(this);
	}


    // IDirectorable

    /**
     * Sets an actor that this director will manage. This will automatically inform the director of all the actor's cues.
     * 
     * @param actor Reference to the actor instance that this director will manage.
     */
    public function addActor(actor:IActorable):Void {
        if (this.actors.contains(actor) == true) {
            return;
        }
        // Actor not yet listed, so add.
        this.actors.push(actor);
        actor.director = this;
        // Inform director of all the actor's cues to be registered.
        var actorCues = actor.cues();
        for (cueName in actorCues.keys()) {
            informActorCueRegistered(cueName, actor);
        }
    }

    /**
     * The dircetor will no longer manage the actor. This will automatically unregister all cues of the actor from the dircetor.
     * 
     * @param actor Reference to the actor instance that this director will no longer manage.
     */
    public function removeActor(actor:IActorable):Void {
        if (this.actors.contains(actor) == false) {
            return;
        }
        // Remove actor from the list
        this.actors.remove(actor);
        actor.director = null;
        // Inform director of all the actor's cues to be unregistered.
        var actorCues = actor.cues();
        for (cueName in actorCues.keys()) {
            informActorCueUnregistered(cueName, actor);
        }
    }
 
    /**
     * For performance sake, when an actor managed by this director has a new cue registered, the director is informed.
     * 
     * @param cueName The name of the cue.
     * @param actor Reference to the actor monitoring for the cue.
     */
    public function informActorCueRegistered(cueName:String, actor:IActorable):Void {
        var actors = this.registeredCues.get(cueName);
        // Cue may not be registered yet
        if (actors == null) {
            this.registeredCues.set(cueName, [actor]);
            return;
        }
        // If actor already registered for the cue, skip.
        if (actors.contains(actor)) {
            return;
        }
        // Map cue to actor.
        actors.push(actor);
    }
 
    /**
     * For performance sake, when an actor managed by this director has a cue unregistered, the director is informed.
     * 
     * @param cueName The name of the cue.
     * @param actor Reference to the actor monitoring for the cue.
     */
    public function informActorCueUnregistered(cueName:String, actor:IActorable):Void {
        var actors = this.registeredCues.get(cueName);
        // Cue may not be registered yet
        if (actors == null) {
            return;
        }
        // If actor already registered for the cue, skip.
        actors.remove(actor);
        // If no more actors monitoring the cue, remove cue entirely from the map.
        if (actors.length == 0) {
            this.registeredCues.remove(cueName);
        }
    }

    /**
	 * Calls a cue.
	 * 
	 * @param cueName The name of the cue being called.
	 * @param userData Additional data to pass to the cue function.
	 * @param director Reference to the invoking director.
	 */
    public override function signalCue(cueName:String, userData:Any, ?director:IDirectorable = null) {
        if (cueName == null) {
            return;
        }
        // Director to morph as actor if director is self.
        if (director == this) {
            super.signalCue(cueName, userData, director);
            return;
        }
        // Invoke actor cues
        var cues = this.registeredCues.get(cueName);
        if (cues == null) {
            return;
        }
        for (actor in cues) {
            actor.signalCue(cueName, userData, this);
        }
    }

}
