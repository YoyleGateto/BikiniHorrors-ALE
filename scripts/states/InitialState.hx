import SequenceHandler;
import funkin.visuals.objects.FunkinSprite;

function onCreate()
{
	Conductor.play(Paths.music("freeplay"));
	Conductor.music.volume = 0.5;
	
	textBox = new FlxSprite(0, FlxG.height - 300).loadGraphic(Paths.image("dialouges/textbox"));
	textBox.screenCenter(1);
	add(textBox);
	SequenceHandler.box = textBox;
	
	textShadow = new FlxText(textBox.x + 72, textBox.y + 72, FlxG.width - 320, "mishWebos").setFormat(Paths.font("vcr.ttf"), 30, FlxColor.BLACK, "left");
	add(textShadow);
	
	text = new FlxText(textBox.x + 70, textBox.y + 70, FlxG.width - 320, "mishWebos").setFormat(Paths.font("vcr.ttf"), 30, 0xFFFF00FF, "left");
	add(text);
	SequenceHandler.dialouge = text;
	
	phanes = new FunkinSprite(FlxG.width - 325, FlxG.height - 375);
	phanes.frames = Paths.getAtlas("dialouges/phanes_portrait");
    phanes.scale.set(0.75, 0.75);
	
    phanes.animation.addByPrefix("idle", "idle", 24, true);
    phanes.animation.addByPrefix("feelings", "feelings", 24, true);
    phanes.animation.addByPrefix("sad_talk_left", "talk_sad_left", 24, true);
    phanes.animation.addByPrefix("cool", "cool", 24, true);
    phanes.animation.addByPrefix("default_talk", "default_talk", 24, true);
    phanes.animation.addByPrefix("sad_talk", "triste_talk", 24, true);
    phanes.animation.addByPrefix("up_talk", "up_talk", 24, true);
    phanes.animation.addByPrefix("left_talk", "left_talk", 24, true);
    phanes.animation.addByPrefix("excited", "excited", 24, true);
    phanes.animation.addByPrefix("wave", "wave", 24, true);
    phanes.animation.addByPrefix("sad_wave", "sad_wave", 24, true);
    phanes.animation.addByPrefix("worried", "worried", 24, true);
    phanes.animation.addByPrefix("paper", "paper", 24, true);
    phanes.animation.addByPrefix("look_paper", "look_paper", 12, false);
    phanes.animation.addByPrefix("playa", "playa", 4, true);
    phanes.animation.addByPrefix("wait", "wait", 24, true);
    offsetToPhanes("default_talk", 0, 6);
    offsetToPhanes("left_talk", 0, 6);
    offsetToPhanes("sad_talk", 0, 6);
    offsetToPhanes("wave", 140, 230);
    offsetToPhanes("sad_wave", 140, 230);
    offsetToPhanes("worried", 30, 0);
    offsetToPhanes("cool", 100, 0);
    offsetToPhanes("excited", 0, -50);
    offsetToPhanes("wait", 50, 50);
    phanes.animation.callback = (a,b,c) -> {
    	phanes.applyOffset();
    }
    add(phanes);
}

function postCreate()
{
	SequenceHandler.initSequence([
		() -> {
			phanes.animation.play("wave", true);
			SequenceHandler.doDialouge("HOLA GUERREROESPONJA!!!!", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("default_talk", true);
			SequenceHandler.doDialouge("vaya tio, no me espere que volvieras tan pronto", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("worried", true);
			SequenceHandler.doDialouge("bueno|w.|w.|w.|w demasiado pronto", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("worried", true);
			SequenceHandler.doDialouge("veras|w.|w.|w.", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("worried", true);
			SequenceHandler.doDialouge("los de ale p me dijeron lo que paso entre ellos y los de codename\n|w|wel motor en el que estan mi mod", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("worried", true);
			SequenceHandler.doDialouge("y que mi mod es medio bodrio por tener codigo algo mal hecho", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("default_talk", true);
			SequenceHandler.doDialouge("asi que decidi pasarlo todo a ale p y mejorar algo del codigo", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("worried", true);
			SequenceHandler.doDialouge("aunque|w.|w.|w.|w aun no esta listo y solo llegue a colocar unos cuantos juegos mios por ahora. (2 / 45)", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("cool", true);
			SequenceHandler.doDialouge("pero seguire actualizando esta version poco a poco", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("excited", true);
			SequenceHandler.doDialouge("CADA VEZ CON MAS CONTENIDO DEL ORIGINAL!!!!!", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("default_talk", true);
			SequenceHandler.doDialouge("ah, y si preguntas pq hablo español", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("default_talk", true);
			SequenceHandler.doDialouge("es porque los de este motor, hablan ese idioma", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("excited", true);
			SequenceHandler.doDialouge("pero bueno sin mas rollo disfruta lo que tengo hasta ahora", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.animation.play("wave", true);
			SequenceHandler.doDialouge("ADIOS!!!!!", false, false, ["sp0", "sp1", "sp2", "sp3"]);
		},
		() -> {
			phanes.visible = false;
			FlxG.sound.music?.stop();
			CoolUtil.switchState(new CustomState("TitleState"), true, true);
		}
	]);
}

function onUpdate()
{
	textShadow.text = text.text;
	phanes.visible = textBox.visible;
	SequenceHandler.conditionUpdate();
}

function offsetToPhanes(anim, x, y)
{
	phanes.offsets.set(anim, {x:x,y:y});
}