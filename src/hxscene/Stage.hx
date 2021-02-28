package hxscene;

/**
 * Stage is the vessel for all the things.
 * The stage is the platform to which scenes, directors, and actors collectively work on.
 */
class Stage implements IStageable {
    // public var id:Int;
    // public var scenes:Array<Scene>;
    // public var sceneCurrentIdx:Int;
    // public var stageLoaded:Bool;

    // public function new() {
    //     this.id = -1;
    //     this.scenes = new Array<Scene>();
    //     this.sceneCurrentIdx = -1;
    //     this.stageLoaded = false;
    // }

    // public function addScene(scene:Scene) {
    //     this.scenes.push(scene);
    //     scene.id = this.scenes.length;
    //     scene.stage = this;
    // }

    // public function setCurrentScene(sceneIdx:Int) {
    //     if (sceneIdx < 0 || sceneIdx >= this.scenes.length) {
    //         return;
    //     }
    //     this.sceneCurrentIdx = sceneIdx;
    //     var scene = this.scenes[sceneIdx];
    //     if (this.stageLoaded) {
    //         scene.load();
    //     }
    //     scene._setAsCurrent();
    // }

    // public function load() {
    //     if (this.sceneCurrentIdx < 0 || this.sceneCurrentIdx >= this.scenes.length) {
    //         return;
    //     }
    //     var scene = this.scenes[this.sceneCurrentIdx];
    //     scene.load();
    //     this.stageLoaded = true;
    // }

    // // public function signalMouseCue(target:Any, x:Int, y:Int, isTouch:Bool) {
    // //     if (this.sceneCurrentIdx < 0 || this.sceneCurrentIdx >= this.scenes.length) {
    // //         return;
    // //     }
    // //     var scene = this.scenes[this.sceneCurrentIdx];
    // //     scene.signalMouseCue(target, x, y, isTouch);
    // // }

    // public function signalCue(cueName:String, userData:Any) {
    //     if (this.sceneCurrentIdx < 0 || this.sceneCurrentIdx >= this.scenes.length) {
    //         return;
    //     }
    //     var scene = this.scenes[this.sceneCurrentIdx];
    //     scene.signalCue(cueName, userData);
    // }

    // public function update(dt:Float) {
    //     if (this.sceneCurrentIdx < 0 || this.sceneCurrentIdx >= this.scenes.length) {
    //         return;
    //     }
    //     var scene = this.scenes[this.sceneCurrentIdx];
    //     scene.update(dt);
    // }

    // public function draw() {
    //     if (this.sceneCurrentIdx < 0 || this.sceneCurrentIdx >= this.scenes.length) {
    //         return;
    //     }
    //     var scene = this.scenes[this.sceneCurrentIdx];
    //     scene.draw();
    // }
}
