package hxscene;

/**
 * Interface of Stage.
 * 
 * The stage is the platform to which scenes, directors, and actors collectively work on.
 */
interface IStageable extends IEntity extends ILoadable extends ISignalable extends IUpdateable extends IDrawable {

    /**
     * List of all scenes.
     * 
     * @return Array of scenes that have been add to this stage.
     */
    public function scenes():Array<ISceneable>;

    /**
     * Add a scene to the stage.
     * 
     * @param scene Reference to the scene.
     */
    public function addScene(scene:ISceneable):Void;

    /**
     * Remove a scene from the stage.
     * 
     * @param scene Reference to the scene.
     */
    public function removeScene(scene:ISceneable):Void;

    /**
     * Sets a scene as the active scene
     * @param scene Reference to the scene. 
     */
    public function setCurrentScene(scene:ISceneable):Void;

    /**
     * Reference to the currently active scene.
     * 
     * @return ISceneable reference of the currently active scene.
     */
    public function currentScene():ISceneable;

}
