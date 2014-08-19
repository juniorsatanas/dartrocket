part of dartrocket;

/**
 * Camera can change the view of the world.
 */
class Camera extends StageXL.DisplayObjectContainer {

  Game _game;

  World _world;

  bool _following = false;

  Sprite _targetSprite;

  num _targetWorldX;

  num _targetWorldY;

  /**
   * Widht of the world.
   */
  num width;

  /**
   * Height of the world.
   */
  num height;

  Camera(this._game, this._world) {
    _game.stage.addChild(this);

    width = _game.stage.sourceWidth;
    height = _game.stage.sourceHeight;

    pivotX = width ~/ 2;
    pivotY = height ~/ 2;
  }
  
  /**
   * Moves the camera by distance.
   */
  void moveDistance(String direction, {int distance: 5}) {
    switch (direction) {
      case Direction.UP:
        _world.y += distance;
        break;
      case Direction.DOWN:
        _world.y -= distance;
        break;
      case Direction.LEFT:
        _world.x += distance;
        break;
      case Direction.RIGHT:
        _world.x -= distance;
        break;
    }
  }
  
  /**
   * Camera will follow the target.
   */
  void follow(Sprite target) {
    _targetSprite = target;
    _following = true;
  }
  
  /**
   * Camera will not follow the target.
   */
  void unfollow() {
    _following = false;
    _targetSprite = null;
  }
  
  void _update() {
    if (_following) {
      _targetWorldX = _world.x + _targetSprite.x;
      _targetWorldY = _world.y + _targetSprite.y;

      if (_targetWorldX != pivotX || _targetWorldY != pivotY) {

        num diffX = pivotX - _targetWorldX;
        num diffY = pivotY - _targetWorldY;

        _world.x += diffX;
        _world.y += diffY;
      }
    }
  }

}
