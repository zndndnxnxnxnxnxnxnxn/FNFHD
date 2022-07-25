package;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

import ui.FlxVirtualPad;

import Config;

class Mobilecontrols extends FlxSpriteGroup
{
    var _pad:FlxVirtualPad;
	var controlmode:Int = 0;

	private var controls(get, never):Controls;
	inline function get_controls():Controls
		return PlayerSettings.player1.controls;
	//keys
	public var UP:Bool;
	public var RIGHT:Bool;
	public var DOWN:Bool;
	public var LEFT:Bool;

	public var UP_P:Bool;
	public var RIGHT_P:Bool;
	public var DOWN_P:Bool;
	public var LEFT_P:Bool;

	public var UP_R:Bool;
	public var RIGHT_R:Bool;
	public var DOWN_R:Bool;
	public var LEFT_R:Bool;

	var config:Config = new Config();

	// now controls here
    public function new()
    {
        super();

		//controlmode
		//If you see this and there's nothing new that means smokey helped us like a legend he is.
		_pad = new FlxVirtualPad(RIGHT_FULL, NONE);
		trace('added the pad lol!');
		_pad.alpha = 0.75;
		trace('amogus sussy imposter');
		this.add(_pad);
		_pad = config.loadcustom(_pad);
		trace('hi lol 2');
    }

	override public function update(elapsed:Float) {
		group.update(elapsed);

		if (moves)
			updateMotion(elapsed);
		
		UP = _pad.buttonUp.pressed;
		RIGHT = _pad.buttonRight.pressed;
		DOWN = _pad.buttonDown.pressed;
		LEFT = _pad.buttonLeft.pressed;

		UP_P = _pad.buttonUp.justPressed;
		RIGHT_P = _pad.buttonRight.justPressed;
		DOWN_P = _pad.buttonDown.justPressed;
		LEFT_P = _pad.buttonLeft.justPressed;

		UP_R = _pad.buttonUp.justReleased;
		RIGHT_R = _pad.buttonRight.justReleased;
		DOWN_R = _pad.buttonDown.justReleased;
		LEFT_R = _pad.buttonLeft.justReleased;
	}
}

