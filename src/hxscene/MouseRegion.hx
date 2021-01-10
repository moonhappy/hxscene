package hxscene;

/**
 * Represents a region/rectangle area that a mouse cursor can interact with.
 */
class MouseRegion {
    public var x:Int;
    public var y:Int;
    public var w:Int;
    public var h:Int;

    public function new(x:Int, y:Int, w:Int, h:Int) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
}
