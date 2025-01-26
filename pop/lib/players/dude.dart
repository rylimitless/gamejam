

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pop/components/block.dart';
import 'package:pop/components/ceiling.dart';
import 'package:pop/components/ground.dart';
import 'package:pop/pop.dart';
import 'package:pop/components/bullet.dart';

import 'pink.dart';


enum PlayerState {attack , idle , run , jump , shoot , moveAttack}


class Dude extends SpriteAnimationComponent with  CollisionCallbacks, KeyboardHandler,  HasGameReference<PopGame>{

  late final Map<PlayerState, SpriteAnimation> animations;
  PlayerState currentState = PlayerState.idle;

  double health = 100;

  late final TimerComponent _bulletSpawner;
  int horizontalDirection = 0;
  bool moving = false;

  final double gravity = 15;
  final double jumpSpeed = 600;
  final double terminalVelocity = 150;

  double attackDuration = 1.0; // Duration in seconds
  double attackTimer = 0.0;
  bool isAttacking = false;

  double moveTimer = 0.0;
  double moveDuration = 0.5;
  bool isOnGround = false;
  bool hasJumped = false;

  bool ismoveAttack = false;

  final Vector2 velocity2 = Vector2.zero();
  final double moveSpeed = 100;
  final Vector2 fromAbove = Vector2(0, -1);
  final Vector2 fromBelow = Vector2(0, 1);



  PlayerState getState() {
    return currentState;
  }


  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    size = Vector2.all(32);

     animations = {
      PlayerState.idle: SpriteAnimation.fromFrameData(
        game.images.fromCache('sprites/Dude_Monster/Dude_Monster_Idle_4.png'),
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2.all(32),
          stepTime: 0.12,
        ),
      ),
      PlayerState.attack: SpriteAnimation.fromFrameData(
        game.images.fromCache('sprites/Dude_Monster/Dude_Monster_Attack1_4.png'),
        SpriteAnimationData.sequenced(
          amount: 4,  // adjust based on your sprite sheet
          textureSize: Vector2.all(32),
          stepTime: 0.12,
        ),
      ),

      PlayerState.run : SpriteAnimation.fromFrameData(
        game.images.fromCache('sprites/Dude_Monster/Dude_Monster_Run_6.png'),
        SpriteAnimationData.sequenced(amount: 6, stepTime: 0.15, textureSize: Vector2.all(32))
        ),

        PlayerState.jump : SpriteAnimation.fromFrameData(
        game.images.fromCache('sprites/Dude_Monster/Dude_Monster_Jump_8.png'),
        SpriteAnimationData.sequenced(amount: 8, stepTime: 0.15, textureSize: Vector2.all(32))
        ),

        // PinkState.moveAttack : SpriteAnimation.fromFrameData(
        // game.images.fromCache('sprites/Pink_Monster_Walk+Attack_6.png'),
        // SpriteAnimationData.sequenced(amount: 8, stepTime: 0.15, textureSize: Vector2.all(32))
        // ),
    };

    // Set initial animation
    animation = animations[currentState];

    add(CircleHitbox());

    return super.onLoad();
  }

   @override
void onCollisionEnd(PositionComponent other) {
  // Add this to detect when ember leaves the ground
  if (other is Ground || other is Ceiling) {
    isOnGround = false;
  }
  super.onCollisionEnd(other);
}


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

   if (other is Pink) {
    if (intersectionPoints.length == 2) {
      // Calculate the collision normal and separation distance.
      final mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;
      final collisionNormal = absoluteCenter - mid;
      final separationDistance = (size.x / 2) - collisionNormal.length;

        collisionNormal.normalize();
        position += collisionNormal.scaled(separationDistance);
    }

    //TODO add checks to see who is attacking or so
    if (currentState == PlayerState.attack){
      other.OnHit(10);
    }
  }

  if (other is BlockComponent || other is Ground){
    

        if (intersectionPoints.length == 2) {
      // Calculate the collision normal and separation distance.
      final mid = (intersectionPoints.elementAt(0) +
        intersectionPoints.elementAt(1)) / 2;

      final collisionNormal = absoluteCenter - mid;
      final separationDistance = (size.x / 2) - collisionNormal.length;
      collisionNormal.normalize();

      // If collision normal is almost upwards,
      // ember must be on ground.
      if (fromAbove.dot(collisionNormal) > 0.9) {
        isOnGround = true;
      }

      if (fromBelow.dot(collisionNormal) > 0.9) {
          velocity2.y = 0; // Stop upward movement
      }

      // Resolve collision by moving ember along
      // collision normal by separation distance.
      position += collisionNormal.scaled(separationDistance);
      }
    
  }

    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {


    hasJumped = keysPressed.contains(LogicalKeyboardKey.arrowUp);

    if (keysPressed.contains(LogicalKeyboardKey.enter)){
      isAttacking = true;
      attackTimer = 0.0;
      currentState = PlayerState.attack;
      animation = animations[currentState];
      moving = false;
     
    }

    horizontalDirection = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
      print('a pressed');
      horizontalDirection += -1;
      moving = true;
    } 
     if (keysPressed.contains(LogicalKeyboardKey.arrowRight)){
      horizontalDirection += 1;
      moving = true;
    } else {
      // moving = false;
    }

    return true;
  }

   @override
  void update(double dt) {

    if(health == 0){
      print("Player dead");
    }
    // print(hasJumped);

    velocity2.y += gravity;  
     position += velocity2 * dt;
    // position += velocity2 * dt;// Apply gravity acceleration

  // Determine if ember has jumped
if (hasJumped) {

  print("Jump called");
  print(isOnGround);
  if (isOnGround) {
    velocity2.y = -jumpSpeed;
    isOnGround = false;
  }
  hasJumped = false;
}


    if(moving) {
      currentState = PlayerState.run;
      animation  = animations[currentState];
      velocity2.x = horizontalDirection * moveSpeed;
      position.x += velocity2.x * dt;

        moveTimer += dt;
      if (moveTimer >= moveDuration) {
        // Reset attack state
        moving = false;
        moveTimer = 0.0;
        currentState = PlayerState.idle;
        animation = animations[currentState];

     

      }

      if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }
    } 

    if (ismoveAttack) {

       currentState = PlayerState.moveAttack;
      animation  = animations[currentState];
      velocity2.x = horizontalDirection * moveSpeed;
      position.x += velocity2.x * dt;

      attackTimer += dt;
      if (attackTimer >= attackDuration) {
        // Reset attack state
        isAttacking = false;
        attackTimer = 0.0;
        currentState = PlayerState.idle;
        animation = animations[currentState];

     

      }

    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    }

    
    // Handle attack timer
    if (isAttacking) {
      attackTimer += dt;
      if (attackTimer >= attackDuration) {
        // Reset attack state
        isAttacking = false;
        attackTimer = 0.0;
        currentState = PlayerState.idle;
        animation = animations[currentState];
      }
    }

    velocity2.y = velocity2.y.clamp(-jumpSpeed, terminalVelocity);

    super.update(dt);

  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void OnHit(){


    add(
    OpacityEffect.fadeOut(
    EffectController(
      alternate: true,
      duration: 0.1,
      repeatCount: 2,
    ),
    )..onComplete = () {
      // hitByEnemy = false;
    },
  );

    health-=10;
    print(health);
  }

  

}

