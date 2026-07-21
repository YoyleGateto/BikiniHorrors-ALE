package;

using StringTools;

class SequenceHandler {
	public static var dialouge:FlxText;
	public static var portrait:FlxSprite;
	public static var box:FlxSprite;
	
	public static var textTimer:FlxTimer;
	public static var sequence:Array = [];
	public static var conditionCallback:Void -> Void;
	
	public static function callEvent():Void {
		if (sequence.length > 0) {
			var ev = sequence.shift();
			ev();
		}
	}
	
	public static function doDialouge(?str:String = "", ?keepText:Bool = false, ?noSkip:Bool = false, ?soundPath:OneOfTwo<String, Array> = "default", ?graphicPath:String = null, ?offset:Float = 0.05){
		conditionCallback = null;
		if (textTimer != null) {
			textTimer.cancel();
		}
		if (graphicPath != null && portrait != null) {
			portrait.loadGraphic(Paths.image("ui/dialouge/face/" + graphicPath));
			portrait.scale.set(4,4);
			portrait.updateHitbox();
			portrait.visible = true;
			if (dialouge != null) dialouge.offset.x = -(portrait.width + 25);
		} else {
			if (dialouge != null) dialouge.offset.x = 0;
			if (portrait != null) portrait.visible = false;
		}
		if (dialouge != null) dialouge.visible = true;
		if (box != null) box.visible = true;
		var sounds = [];
		if (soundPath[0] != null)
			sounds = [for (sound in soundPath) FlxG.sound.load(Paths.sound("dialouge/" + sound ?? "default"))];
		else
			sounds = [FlxG.sound.load(Paths.sound("dialouge/" + soundPath ?? "default"))];
		if (!keepText && dialouge != null)
			dialouge.text = "";
		var chars = str.split("");
		var lastChar = "";
		if (!noSkip) {
			conditionCallback = () -> {
				if(Controls.ACCEPT || FlxG.mouse.justReleased) {
					textTimer.cancel();
					dialouge.text = str.replace("|w", "");
					conditionCallback = () -> {
						if(Controls.ACCEPT || FlxG.mouse.justReleased) {
							endDialouge(keepText);
							return true;
						}
					}
				}
				return false;
			}
		} else {
			conditionCallback = () -> {
				if(Controls.ACCEPT || FlxG.mouse.justReleased) {
					if (textTimer != null) {
						textTimer.cancel();
					}
					dialouge.text = str.replace("|w", "");
					return true;
				}
				return false;
			}
		}
		textTimer = new FlxTimer().start(offset, (ses) -> {
			final nextChar = chars.shift();
			if (dialouge != null) {
				if (nextChar != "\\") {
					if (nextChar == "n" && lastChar == "\\") { 
						dialouge.text += "\n";
						lastChar = nextChar;
						return;
					}
				} else {
					lastChar = nextChar;
					return;
				}
				if (nextChar != "|") {
					if (nextChar == "w" && lastChar == "|") { 
						lastChar = nextChar;
						return;
					}
				} else {
					lastChar = nextChar;
					return;
				}
				dialouge.text += nextChar;
			}
			var sound = sounds[FlxG.random.int(0, sounds.length)];
			if (sound != null)
				sound.play(true);
			lastChar = nextChar;
			if (chars.length == 0) {
				if (!noSkip) {
					conditionCallback = () -> {
						if(Controls.ACCEPT || FlxG.mouse.justReleased) {
							endDialouge(keepText);
							return true;
						}
					}
				} else {
					callEvent();
				}
			}
		}, chars.length);
	}
	
	public static function endDialouge(keepText) {
		if (!keepText && dialouge != null) dialouge.text = "";
		if (portrait != null) portrait.visible = false;
		if (dialouge != null) dialouge.visible = false;
		if (box != null) box.visible = false;
	}
	
	public static function conditionUpdate() {
		if (conditionCallback != null) {
			var result = conditionCallback();
			if (result) {
				conditionCallback = null;
				callEvent();
			}
		}
	}
	
	public static function initSequence(sequenceEvents:Array) {
		sequence = sequenceEvents;
		callEvent();
	}
}