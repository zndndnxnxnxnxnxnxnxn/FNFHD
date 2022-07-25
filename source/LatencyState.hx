package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import ui.FlxVirtualPad;

class LatencyState extends FlxState
{
    var _pad:FlxVirtualPad;
    var statedied:Bool = false;
	var offsetText:FlxText;
	var noteGrp:FlxTypedGroup<Note>;
	var strumLine:FlxSprite;

	override function create()
	{
		FlxG.sound.playMusic(Paths.sound('soundTest'));

		noteGrp = new FlxTypedGroup<Note>();
		add(noteGrp);

		for (i in 0...32)
		{
			var note:Note = new Note(Conductor.crochet * i, 1);
			noteGrp.add(note);
		}

		offsetText = new FlxText();
		offsetText.screenCenter();
		add(offsetText);

		strumLine = new FlxSprite(FlxG.width / 2, 100).makeGraphic(FlxG.width, 5);
		add(strumLine);

		Conductor.changeBPM(120);

//cringe
		_pad = new FlxVirtualPad(LEFT_RIGHT, A_B);
		_pad.alpha = 0.75;
		this.add(_pad);

		super.create();
	}

	override function update(elapsed:Float)
	{
		offsetText.text = "Offset: " + Conductor.offset + "ms";

		Conductor.songPosition = FlxG.sound.music.time - Conductor.offset;

		var multiply:Float = 1;

        if (!statedied)
        {
//mobile controls
            var LEFT_P:Bool = false;
            var RIGHT_P:Bool = false;
            var BACK:Bool = false;
            var ACCEPT:Bool = false;
            LEFT_P = _pad.buttonLeft.justPressed;
            RIGHT_P = _pad.buttonRight.justPressed;
            BACK = _pad.buttonB.justPressed;
            ACCEPT = _pad.buttonA.justPressed;
	    	if (ACCEPT)
		    	multiply = 10;

		    if (RIGHT_P)
		    	Conductor.offset += 1 * multiply;
	    	if (LEFT_P)
		    	Conductor.offset -= 1 * multiply;

	    	if (BACK)
	    	{
	    		FlxG.sound.music.stop();
	    		statedied = true;

	    		FlxG.resetState();
	    	}
        }

		noteGrp.forEach(function(daNote:Note)
		{
			daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * 0.45);
			daNote.x = strumLine.x + 30;

			if (daNote.y < strumLine.y)
				daNote.kill();
		});

		super.update(elapsed);
	}
}
