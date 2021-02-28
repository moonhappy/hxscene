package hxscene;

/**
 * Interface of an Actor.
 * 
 * An actor is an entity that resembles presence and characterisation. Use the
 * actor construct as the foundation to perform the role of an entity in the game.
 * An actor can also be a simple prop (e.g. inanimate carbon rod was a great actor 
 * in the Simpsons).
 */
interface IActorable extends IEntity extends IUpdateable extends IDrawable extends ILoadable extends ISignalable {

}
