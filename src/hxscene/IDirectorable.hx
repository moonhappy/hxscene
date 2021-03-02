package hxscene;

/**
 * Interface of a Director.
 * 
 * The director is like an actor, but is behind the scenes making sure everything
 * goes to "plan". But directors can be actors as well, for the "prima donna" types.
 */
interface IDirectorable extends IEntity extends ISignalable {

    /**
     * Sets an actor that this director will manage. This will automatically inform the director of all the actor's cues.
     * 
     * @param actor Reference to the actor instance that this director will manage.
     */
    public function addActor(actor:IActorable):Void;

    /**
     * The director will no longer manage the actor. This will automatically unregister all cues of the actor from the dircetor.
     * 
     * @param actor Reference to the actor instance that this director will no longer manage.
     */
    public function removeActor(actor:IActorable):Void;

    /**
     * For performance sake, when an actor managed by this director has a new cue registered, the dircetor is informed.
     * 
     * @param cueName The name of the cue.
     * @param actor Reference to the actor monitoring for the cue.
     */
    public function informActorCueRegistered(cueName:String, actor:IActorable):Void;

    /**
     * For performance sake, when an actor managed by this director has a cue unregistered, the dircetor is informed.
     * 
     * @param cueName The name of the cue.
     * @param actor Reference to the actor monitoring for the cue.
     */
    public function informActorCueUnregistered(cueName:String, actor:IActorable):Void;

}
