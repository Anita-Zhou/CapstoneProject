using Godot;
using System;
using System.Collections.Generic;

public class Sprite : Godot.Sprite
{
	// Declare member variables here. Examples:
	// 0 means up, 1 means left, 2 means down, 3 means right
	private int dirc = 0;
	private Dictionary<int, Vector2> dirDict = new Dictionary<int, Vector2>{
		{0, new Vector2(0, -20)},
		{1, new Vector2(-20, 0)},
		{2, new Vector2(0, 20)},
		{3, new Vector2(20, 0)}
	};

	// Called when the node enters the scene tree for the first time.


	public override void _Ready()
	{
		
	}

 // Called every frame. 'delta' is the elapsed time since the previous frame.
 public override void _Process(float delta)
 {
	Godot.AnimatedSprite sword = this.GetNode<Godot.AnimatedSprite>("sword");
	sword.Connect("animation_finished", sword, "stop");		

	float AMOUNT = 6;

	if (Input.IsKeyPressed((int)KeyList.W)){
		this.Position += new Vector2(0, -AMOUNT);
		this.dirc = 0;
	}
	if (Input.IsKeyPressed((int)KeyList.A)){
		this.Position += new Vector2(-AMOUNT, 0);
		this.dirc = 1;
	}
	if (Input.IsKeyPressed((int)KeyList.S)){
		this.Position += new Vector2(0, AMOUNT);
		this.dirc = 2;
	}
	if (Input.IsKeyPressed((int)KeyList.D)){
		this.Position += new Vector2(AMOUNT, 0);
		this.dirc = 3;
	}
	if (Input.IsKeyPressed((int)KeyList.Space)){
		this.Position += dirDict[this.dirc];
	}
	// if (Input.IsKeyPressed((int)KeyList.J)){
	// 	sword.Play("attack", false);
	// }
	 
 }

	public override void _UnhandledInput(InputEvent @event){
		Godot.AnimatedSprite sword = this.GetNode<Godot.AnimatedSprite>("sword");
		sword.Connect("animation_finished", sword, "stop");		
		if (@event is InputEventMouseButton mouseEvent){
			sword.Play("attack", false);
		}
	}
}
