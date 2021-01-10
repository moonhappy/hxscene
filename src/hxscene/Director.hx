package hxscene;

/**
 * Director to boss actors around.
 * 
 * The director is like an actor, but is behind the scenes making sure everything
 * goes to "plan". But directors can be actors.
 */
class Director extends Actor {

    public var actors:Array<Actor>;
    public var _actorCues:Array<ActorCue>;
	
	/**
	 * Default constructor.
	 */
	public override function new(drawLayer = 0) {
        super(drawLayer);
		this.actors = new Array<Actor>();
        this._actorCues = new Array<ActorCue>();
        this.setVisible(false);
    }

    public function addActor(actor:Actor) {
        if (actor == null) {
            return;
        }
        this.actors.push(actor);
        actor.director = this;
    }

    public function addDirector(director:Director) {
        this.addActor(director);
    }

    public function _addCues(fromCues:Array<ActorCue>, toCues:Array<ActorCue>) {
        toCues = toCues.concat(fromCues);
    }

    public override function _setScene(id:Int, scene:Scene) {
        if (scene == null) {
            return;
        }
        this.id = id;
        this.scene = scene;
        // Clear actor cues, ready for re-add opperation.
        this._actorCues = new Array<ActorCue>();
        // Add cues from actors.
        scene._clearDirectorActors(this);
        for (actor in this.actors) {
            this._addCues(actor.cues, this.cues);
            scene.addActor(actor);
        }
        // Add cues to the scene.
        this._addCues(this.cues, scene.cues);
        this._addCues(this._actorCues, scene.cues);
    }
}
