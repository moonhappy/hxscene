package hxscene;

/**
 * Represents a "cue" or "signal" that triggers an actor.
 */
class ActorCue {
	public var cue:String;
    public var cb:String;
    public var obj:Any;
    public var dir:Director;

    public function new(cue:String, cb:String, obj:Any, dir:Director) {
        this.cue = cue;
        this.cb = cb;
        this.obj = obj;
        this.dir = dir;
    }
}
