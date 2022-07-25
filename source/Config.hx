package;

import flixel.FlxG;
import ui.FlxVirtualPad;
import ui.Hitbox;
import flixel.util.FlxSave;
import flixel.math.FlxPoint;

using StringTools;

class Config
{
    var save:FlxSave;

    public function new() 
    {
        save = new FlxSave();
    	save.bind("saveconrtol");
    }

	public static var offset:Float;
	public static var accuracy:String;
	public static var healthMultiplier:Float;
	public static var healthDrainMultiplier:Float;
	public static var betterIcons:Bool;
	public static var downscroll:Bool;
	public static var newInput:Bool;
	public static var noteGlow:Bool;
	public static var noRandomTap:Bool;
	public static var disableCutscenes:String;

	public static function resetSettings():Void{

		FlxG.save.data.offset = 0.0;
		FlxG.save.data.accuracy = "simple";
		FlxG.save.data.healthMultiplier = 1.0;
		FlxG.save.data.healthDrainMultiplier = 1.0;
		FlxG.save.data.betterIcons = true;
		FlxG.save.data.downscroll = false;
		FlxG.save.data.newInput = true;
		FlxG.save.data.noteGlow = false;
		FlxG.save.data.noRandomTap = false;
		FlxG.save.data.disableCutscenes = 'story';
		reload();

	}
	
	public static function reload():Void
	{
		offset = FlxG.save.data.offset;
		accuracy = FlxG.save.data.accuracy;
		healthMultiplier = FlxG.save.data.healthMultiplier;
		healthDrainMultiplier = FlxG.save.data.healthDrainMultiplier;
		betterIcons = FlxG.save.data.betterIcons;
		downscroll = FlxG.save.data.downscroll;
		newInput = FlxG.save.data.newInput;
		noteGlow = FlxG.save.data.noteGlow;
		noRandomTap = FlxG.save.data.noRandomTap;
		disableCutscenes = FlxG.save.data.disableCutscenes;
	}
	
	public static function write(
								offsetW:Float, 
								accuracyW:String, 
								healthMultiplierW:Float, 
								healthDrainMultiplierW:Float, 
								betterIconsW:Bool, 
								downscrollW:Bool, 
								newInputW:Bool,
								noteGlowW:Bool,
								noRandomTapW:Bool,
								disableCutscenesW:String
								):Void
	{

		FlxG.save.data.offset = offsetW;
		FlxG.save.data.accuracy = accuracyW;
		FlxG.save.data.healthMultiplier = healthMultiplierW;
		FlxG.save.data.healthDrainMultiplier = healthDrainMultiplierW;
		FlxG.save.data.betterIcons = betterIconsW;
		FlxG.save.data.downscroll = downscrollW;
		FlxG.save.data.newInput = newInputW;
		FlxG.save.data.noteGlow = noteGlowW;
		FlxG.save.data.noRandomTap = noRandomTapW;
		FlxG.save.data.disableCutscenes = disableCutscenesW;
		
		reload();

	}
	
	public static function configCheck():Void
	{
		if(FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0.0;
		if(FlxG.save.data.accuracy == null)
			FlxG.save.data.accuracy = "simple";
		if(FlxG.save.data.healthMultiplier == null)
			FlxG.save.data.healthMultiplier = 1.0;
		if(FlxG.save.data.healthDrainMultiplier == null)
			FlxG.save.data.healthDrainMultiplier = 1.0;
		if(FlxG.save.data.betterIcons == null)
			FlxG.save.data.betterIcons = true;
		if(FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;
		if(FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;
		if(FlxG.save.data.noteGlow == null)
			FlxG.save.data.noteGlow = false;
		if(FlxG.save.data.noRandomTap == null)
			FlxG.save.data.noRandomTap = false;
		if(FlxG.save.data.disableCutscenes == null)
			FlxG.save.data.disableCutscenes = 'story';
		//bruh
		


		if(FlxG.save.data.ee1 == null)
			FlxG.save.data.ee1 = false;
	}
	//MOBILE HERE ASSHOLE
    public function getcontrolmode():Int {
        // load control mode num from FlxSave
		if (save.data.buttonsmode != null) return save.data.buttonsmode[0];
        return 0;
    }

    public function setcontrolmode(mode:Int = 0):Int {
        // save control mode num from FlxSave
		if (save.data.buttonsmode == null) save.data.buttonsmode = new Array();
        save.data.buttonsmode[0] = mode;
        save.flush();

        return save.data.buttonsmode[0];
    }

    public function savecustom(_pad:FlxVirtualPad) {
		trace("saved");

		if (save.data.buttons == null)
		{
			save.data.buttons = new Array();

			for (buttons in _pad)
			{
				save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
			}
		}else
		{
			var tempCount:Int = 0;
			for (buttons in _pad)
			{
				save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}
		save.flush();
	}

	public function loadcustom(_pad:FlxVirtualPad):FlxVirtualPad {
		//load pad
		if (save.data.buttons == null) return _pad;
		var tempCount:Int = 0;

		for(buttons in _pad)
		{
			buttons.x = save.data.buttons[tempCount].x;
			buttons.y = save.data.buttons[tempCount].y;
			tempCount++;
		}	
        return _pad;
	}
}