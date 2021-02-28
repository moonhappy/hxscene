package hxscene;

/**
 * Interface of a Scene.
 * 
 * The scene contains an assortment of actors.
 */
interface ISceneable extends IEntity extends ISignalable extends ILoadable extends IUpdateable extends IDrawable {

    /**
     * Add an actor to the scene.
     * 
     * @param actor Reference to the actor.
     */
    public function addActor(actor:IActorable):Void;

    /**
     * Remove an actor from the scene.
     * 
     * @param actor Reference to the actor.
     */
     public function removeActor(actor:IActorable):Void;

    /**
     * Add a director to the scene.
     * 
     * @param director Reference to the director.
     */
    public function addDirector(director:IDirectorable):Void;

    /**
     * Remove a director from the scene.
     * 
     * @param director Reference to the director.
     */
     public function removeDirector(director:IDirectorable):Void;

}
