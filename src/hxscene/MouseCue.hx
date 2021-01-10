package hxscene;

/**
 * Represents a mouse "cue" or "signal".
 */
class MouseCue {
    public var r:MouseRegion;
    public var cb:String;
    public var obj:Any;

    public function new(r:MouseRegion, cb:String, obj:Any) {
        this.r = r;
        this.cb = cb;
        this.obj = obj;
    }
}
