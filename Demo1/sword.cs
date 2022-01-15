using Godot;
using System;

public class sword : Godot.AnimatedSprite
{
	// Declare member variables here. Examples:
	// private int health = 200;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

 // Called every frame. 'delta' is the elapsed time since the previous frame.
 public override void _Process(float delta){

 }
//  {
// 	Godot.AnimatedSprite sword = this.GetNode<Godot.AnimatedSprite>("sword");

// 	float AMOUNT = 6;
// 	if (Input.IsKeyPressed((int)KeyList.W)){
// 		this.Position += new Vector2(0, -AMOUNT);
// 	}
// 	if (Input.IsKeyPressed((int)KeyList.A)){
// 		this.Position += new Vector2(-AMOUNT, 0);
// 	}
// 	if (Input.IsKeyPressed((int)KeyList.S)){
// 		this.Position += new Vector2(0, AMOUNT);
// 	}
// 	if (Input.IsKeyPressed((int)KeyList.D)){
// 		this.Position += new Vector2(AMOUNT, 0);
// 	}
// 	if (Input.IsKeyPressed((int)KeyList.J)){
// 		sword.Play("attack", false);
// 	}

}
